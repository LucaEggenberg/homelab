{ config, lib, pkgs, inputs, self, ... }: {
    systemd.services.scavenger-miner = {
        description = "Midnight scavenger miner";
        after = [ "network-online.target" ];

        serviceConfig = {
            Environment = [
                "NETWORK=mainnet"
                "RUST_LOG=info"
                "SCAVENGER_API=https://scavenger.prod.gd.midnighttge.io"
            ];

            ExecStart = "${self.packages.${pkgs.system}.miner}/bin/scavenger-miner --network mainnet --keystore keystore_mainnet mine";

            Restart = "always";
            RestartSec = "5s";
            Nice = 10;
        };

        wantedBy = [ "multi-user.target" ];
    };

    environment.systemPackages = [
        self.packages.${pkgs.system}.miner
    ];
}