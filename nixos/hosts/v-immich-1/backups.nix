{ config, pkgs, ... }: {
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
    after = [ "network-online.target" "immich-server.service" "mnt-share.mount" ];
    requires = [ "mnt-share.mount" ];

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };

    path = with pkgs; [
      postgresql_16
      rsync
      zstd
      coreutils
      findutils
      gnutar
      util-linux
    ];

    script = ''
      set -euo pipefail

      # Path updated to your new structure
      BACKUPROOT="/mnt/share/backups"
      TODAY="$(date +%Y-%m-%d)"
      TMPDIR="/var/lib/immich-backup-tmp"
      ARCHIVE="$BACKUPROOT/immich-$TODAY.tar.zst"

      mkdir -p "$BACKUPROOT"
      mkdir -p "$TMPDIR"
      
      # FIX: Give postgres permission to write the dump here
      chown postgres:postgres "$TMPDIR"

      echo "Dumping postgres database..."
      runuser -u postgres -- pg_dump -Fc -d immich -f "$TMPDIR/immich.pg.dump"

      echo "Copying app state (excluding heavy media/library)..."
      # exclude 'library' because that's already on the NAS
      rsync -aH --delete \
        --exclude "library" \
        --exclude "cache" \
        --exclude "tmp" \
        /var/lib/immich/ "$TMPDIR/var-lib-immich"

      echo "Creating archive..."
      tar -C "$TMPDIR" -c . | zstd -T0 -19 -o "$ARCHIVE"

      # Cleanup
      rm -rf "$TMPDIR"

      echo "Pruning archives older than 60 days..."
      find "$BACKUPROOT" -name "immich-*.tar.zst" -mtime +60 -delete

      echo "Backup complete: $ARCHIVE"
    '';
  };
}