{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        nut
    ];

    power.ups = {
        enable = true;
        mode = "netclient";
        upsmon = {
            enable = true;
            monitor.powerwalker = {
                system = "ups@storage.eggenberg.io";
                user = "upsmon";
                passwordFile = config.sops.secrets."nut/password".path;
                powerValue = 1;
                type = "slave";
            };
        };
    };
}