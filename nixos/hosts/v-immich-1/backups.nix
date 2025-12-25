{ config, pkgs, ... }: {
  fileSystems."/srv/immich-backups" = {
    device = "10.10.10.20:/mnt/Storage/backups/immich";
    fsType = "nfs";
    options = [
      "noauto"
      "x-systemd.automount"
      "nofail"
      "_netdev"
      "nfsvers=4.1"
      "rsize=1048576"
      "wsize=1048576"
      "hard"
      "timeo=600"
    ];
  };

  systemd.timers.immich-backup = {
    description = "Immich backup";
    wants = [ "immich-backup.service" ];
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "03:15";
      Persistent = true;
    };
  };

  systemd.services.immich-backup = {
    description = "Backup Immich (Postgres dump + app state)";
    after = [ "network-online.target" "immich.service" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
      Group = "root";
    };

    path = [
      pkgs.postgresql_16
      pkgs.rsync
      pkgs.zstd
      pkgs.coreutils
      pkgs.findutils
      pkgs.gnutar
      pkgs.util-linux # runuser
    ];

    script = ''
      set -euo pipefail

      BACKUPROOT="/srv/immich-backups"
      TODAY="$(date +%Y-%m-%d)"
      TMPDIR="/var/lib/immich-backup-$TODAY"
      ARCHIVE="$BACKUPROOT/immich-$TODAY.tar.zst"

      mkdir -p "$TMPDIR"

      echo "dumping postgres database (immich)"
      runuser -u postgres -- pg_dump -Fc -d immich -f "$TMPDIR/immich.pg.dump"

      echo "copying immich app state"
      rsync -aH --delete \
        --exclude "cache" \
        --exclude "tmp" \
        /var/lib/immich/ "$TMPDIR/var-lib-immich" || true

      echo "capturing service unit environment (optional)"
      systemctl cat immich.service > "$TMPDIR/immich.service.txt" 2>/dev/null || true

      echo "creating archive"
      tar -C "$TMPDIR" -c . | zstd -T0 -19 -o "$ARCHIVE"

      echo "fixing ownership for TrueNAS share"
      chown nobody:nogroup "$ARCHIVE" || true

      echo "cleaning up tempdir"
      rm -rf "$TMPDIR"

      echo "pruning old archives"
      find "$BACKUPROOT" -name "immich-*.tar.zst" -mtime +60 -delete

      echo "Backup complete: $ARCHIVE"
    '';
  };
}

