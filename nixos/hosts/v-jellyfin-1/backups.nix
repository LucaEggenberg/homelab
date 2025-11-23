{ config, pkgs, ... }: {
    systemd.tmpfiles.rules = [
        "d /srv/jellyfin-backups 0755 nobody nogroup -"
    ];

    fileSystems."/srv/jellyfin-backups" = {
        device = "10.10.10.20:/mnt/Storage/backups/jellyfin";
        fsType = "nfs";
        options = [
            "nfsvers=4.1"
            "rw"
            "hard"
            "noatime"
            "nodiratime"
            "rsize=1048576"
            "wsize=1048576"
            "timeo=600"
            "_netdev"
        ];
    };

    systemd.timers.jellyfin-backup = {
        description = "jellyfin db backup";
        wants = [ "jellyfin-backup.service" ];
        timerConfig = {
            OnCalendar = "03:00";
            Persistent = true;
        };
    };

    systemd.services.jellyfin-backup = {
        description = "Backup Jellyfin configuration and metadata";
        after = [ "network-online.target" "jellyfin.service" ];
        wants = [ "network-online.target" ];
        
        serviceConfig = {
            Type = "oneshot";
            User = "root";
            Group = "root";
        };

        path = [
            pkgs.sqlite
            pkgs.rsync
            pkgs.zstd
            pkgs.coreutils
            pkgs.findutils
            pkgs.gnutar
        ];

        script = ''
            set -e

            BACKUPROOT="/srv/jellyfin-backups"
            TODAY=$(date +%Y-%m-%d)
            TMPDIR="/var/lib/jellyfin-backup-$TODAY"
            ARCHIVE="$BACKUPROOT/jellyfin-$TODAY.tar.zst"

            mkdir -p "$TMPDIR"

            echo "flushing database"
            sqlite3 /var/lib/jellyfin/data/library.db ".backup '$TMPDIR/library.db'"
            sqlite3 /var/lib/jellyfin/data/queries.db ".backup '$TMPDIR/queries.db'"

            echo "copying config"
            rsync -aH --delete \
                --exclude "transcodes" \
                /var/lib/jellyfin/ "$TMPDIR/var-lib-jellyfin"

            echo "creating archives"
            tar -C "$TMPDIR" -c . | zstd -T0 -19 -o "$ARCHIVE"

            echo "fixing ownership"
            chown nobody:nogroup "$ARCHIVE"

            echo "cleaning up"
            rm -rf "$TMPDIR"

            echo "pruning old archives"
            find "$BACKUPROOT" -name "jellyfin-*.tar.zst" -mtime +60 -delete

            echo "Backup complete: $ARCHIVE"
        '';
    };
}