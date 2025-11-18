{ config, lib, pkgs, inputs, self, ... }: {
    services.xserver = {
        enable = true;
        desktopManager.xfce.enable = true;
        displayManager.lightdm = {
            enable = true;

            autoLogin.enable = true;
            autoLogin.user = "luca";
        };
    };

    services.xrdp.enable = true;
    services.xrdp.openFirewall = true;

    environment.systemPackages = with pkgs; [
        chromium
    ];

    systemd.tmpfiles.rules = [
        "d /home/luca/mining-profiles 0755 luca users -"
        "d /home/luca/mining-profiles/profile1 0700 luca users -"
        "d /home/luca/mining-profiles/profile2 0700 luca users -"
        "d /home/luca/mining-profiles/profile3 0700 luca users -"
        "d /home/luca/mining-profiles/profile4 0700 luca users -"
        "d /home/luca/mining-profiles/profile5 0700 luca users -"
        "d /home/luca/mining-profiles/profile6 0700 luca users -"

        "f /etc/miner-launch.sh 0755 root root -"
    ];

    environment.etc."miner-launch.sh".text = ''
        #!/usr/bin/env bash

        MINER_URL="https://sm.midnight.gd/wizard/mine"

        chromium --user-data-dir=/home/luca/mining-profiles/profile1 "$MINER_URL" &
        chromium --user-data-dir=/home/luca/mining-profiles/profile2 "$MINER_URL" &
        chromium --user-data-dir=/home/luca/mining-profiles/profile3 "$MINER_URL" &
        chromium --user-data-dir=/home/luca/mining-profiles/profile4 "$MINER_URL" &
        chromium --user-data-dir=/home/luca/mining-profiles/profile5 "$MINER_URL" &
        chromium --user-data-dir=/home/luca/mining-profiles/profile6 "$MINER_URL" &
    '';

    environment.etc."xdg/autostart/miner.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Name=Browser Miner Launcher
        Exec=/etc/miner-launch.sh
    '';
}