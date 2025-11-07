{ config, pkgs, ... }: {
    networking.hostName = "v-jellyfin-1";

    hardware.opengl.enable = true;
    hardware.opengl.extraPackages = [ pkgs.vaapiVdpau ];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        open = false;
        nvidiaSettings = false;
    };

    services.jellyfin.enable = true;
}