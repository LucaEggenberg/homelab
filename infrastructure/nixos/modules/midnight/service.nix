{ config, lib, pkgs, inputs, ... }: {
    users.users.scavenger = {
        isSystemUser = true;
        group = "scavenger";
        createHome = false;
    };

    users.groups.scavenger = {};

    systemd.tmpfiles.rules = [
        "d /var/lib/scavenger 0755 scavenger scavenger -"
        "d /var/lib/scavenger/keystore 0700 scavenger scavenger -"
    ];

    
    systemd.services.scavenger-miner = {
        description = "Scavenger Miner (Rust)";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];

        serviceConfig = {
            ExecStart = "${minerPkg}/bin/scavenger-miner mine";

            WorkingDirectory = "/var/lib/scavenger";

            Environment = [
                "SCAVENGER_API=https://scavenger.prod.gd.midnighttge.io"
                "NETWORK=mainnet"
                "KEYSTORE=/var/lib/scavenger/keystore"
                # null → auto use all CPU cores
                "WORKERS="
                "ENABLE_DONATE=0"
                "DONATE_TO="
            ];

            User = "scavenger";
            Group = "scavenger";

            Restart = "always";
            RestartSec = 3;

            NoNewPrivileges = true;
            ProtectSystem = "strict";
            PrivateTmp = true;
            MemoryDenyWriteExecute = true;
        };

        wantedBy = [ "multi-user.target" ];
    };
}