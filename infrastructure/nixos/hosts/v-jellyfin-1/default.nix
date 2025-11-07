{ config, pkgs, lib, ... }: {
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
    
    environment.systemPackages = with pkgs; [
        (lib.getBin config.boot.kernelPackages.nvidiaPackages.production)
        pkgs.cifs-utils
        jellyfin
        jellyfin-web
        jellyfin-ffmpeg
    ];

    services.jellyfin = {
        enable = true;
        openFirewall = true;
        package = pkgs.jellyfin;
    };

    sops.secrets."smb" = {
        sopsFile = ../../secrets/jellyfin/smb.env;
        format = "dotenv";
        mode = "0400";
        owner = "root";
        group = "root";
    };

    fileSystems."/movies" = {
        device = "//p-storage-1.eggenberg.io/media/movies";
        fsType = "cifs";
        options = [
            "credentials={{config.sops.secrets.\"smb\".path;}}"
            "uid=jellyfin"
            "gid=jellyfin"
            "file_mode=0644"
            "dir_mode=0755"
            "vers=3.1.1"
            "x-systemd.automount"
            "noatime"
        ];
    };

    fileSystems."/shows" = {
        device = "//p-storage-1.eggenberg.io/media/shows";
        fsType = "cifs";
        options = [
            "credentials={{config.sops.secrets.\"smb\".path;}}"
            "uid=jellyfin"
            "gid=jellyfin"
            "file_mode=0644"
            "dir_mode=0755"
            "vers=3.1.1"
            "x-systemd.automount"
            "noatime"
        ];
    };

    fileSystems."/TGCCV2" = {
        device = "//p-storage-1.eggenberg.io/media/TGCCV2";
        fsType = "cifs";
        options = [
            "credentials={{config.sops.secrets.\"smb\".path;}}"
            "uid=jellyfin"
            "gid=jellyfin"
            "file_mode=0644"
            "dir_mode=0755"
            "vers=3.1.1"
            "x-systemd.automount"
            "noatime"
        ];
    };
}