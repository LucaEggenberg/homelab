{ config, pkgs, unstable, lib, ... }: {
    networking.hostName = "v-jellyfin-1";

    nixpkgs.config.allowUnfree = true;

    services.xserver.enable = false;
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.opengl.enable = true;
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            vaapiVdpau
            libvdpau-va-gl
        ];
    };

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        powerManagement.enable = false;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.production;
    };
    
    environment.systemPackages = [
        (lib.getBin config.boot.kernelPackages.nvidiaPackages.production)
        pkgs.cifs-utils
        unstable.jellyfin
        unstable.jellyfin-web
        unstable.jellyfin-ffmpeg
    ];

    services.jellyfin = {
        enable = true;
        openFirewall = true;
        package = unstable.jellyfin;
    };

    sops.secrets."smb" = {
        sopsFile = ../../secrets/jellyfin/smb.env;
        format = "dotenv";
        mode = "0400";
        owner = "root";
        group = "root";
    };

    # ensure directories exist for systemd not to fail at boot
    systemd.tmpfiles.rules = [
        "d /media 0755 root root -"
        "d /movies 0755 root root -"
        "d /shows 0755 root root -"
    ];

    fileSystems."/media" = {
        device = "//10.10.10.20/media";
        fsType = "cifs";
        options = [
            "credentials=${config.sops.secrets."smb".path}"
            "_netdev"
            "nofail"
            "x-systemd.automount"
            "vers=3.1.1"
            "uid=jellyfin"
            "gid=jellyfin"
            "file_mode=0775"
            "dir_mode=0775"
            "cache=strict"
            "noserverino"
            "iocharset=utf8"
        ];
    };

    # symlinks to keep current folder structure
    fileSystems."/config" = {
        device = "/var/lib/jellyfin";
        fsType = "none";
        options = [ "bind" ];
    };

    fileSystems."/movies" = {
        device = "/media/movies";
        fsType = "none";
        options = [ "bind" ];
    };

    fileSystems."/shows" = {
        device = "/media/shows";
        fsType = "none";
        options = [ "bind" ];
    };
}