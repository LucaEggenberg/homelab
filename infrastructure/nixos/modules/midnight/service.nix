{ config, lib, pkgs, inputs, self, ... }: {
    systemd.services.scavenger-miner = {
        description = "Midnight scavenger miner";
        after = [ "network-online.target" ];

        serviceConfig = {
            Environment = [
                "NETWORK=mainnet"
                "RUST_LOG=info"
                "KEYSTORE=keystore_mainnet"
                "SCAVENGER_API=https://scavenger.prod.gd.midnighttge.io"
            ];

            ExecStart = ''
                ${self.packages.${pkgs.system}.miner}/bin/scavenger-miner \
                    --network mainnet \
                    --keystore keystore_mainnet \
                    --enable-donate \
                    --donate-to "addr1q8cn7l3uu076wtkgvjzejgv7hjvudvsvgm3hzyq9qqmwjnlapd43a4vqsx85tx56kktz90jj4k3ss7drd8skalunq79sm2jptd" \
                    mine
            '';

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