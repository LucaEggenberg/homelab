{ config, pkgs, unstable, lib, ... }: {
    networking.hostName = "v-jellyfin-1";

    imports = [
        ./backups.nix
    ];

    users.groups.jellyfin.gid = 865;
    users.users.jellyfin = {
        isSystemUser = true;
        uid = 865;
        group = "jellyfin";
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [
        (lib.getBin config.boot.kernelPackages.nvidiaPackages.production)
        pkgs.cifs-utils
        unstable.jellyfin
        unstable.jellyfin-web
        unstable.jellyfin-ffmpeg
    ];

    environment.variables = {
        LIBVA_DRIVER_NAME = "nvidia";
        VDPAU_DRIVER = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    services.xserver = {
        enable = false;
        videoDrivers = [ "nvidia" ];
    };

    hardware.nvidia-container-toolkit.enable = true;
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            nvidia-vaapi-driver
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

    services.jellyfin = {
        enable = true;
        openFirewall = true;
        package = unstable.jellyfin;
    };

    # mount transcode cache in memory
    fileSystems."/var/cache/jellyfin/transcodes" = {
        fsType = "tmpfs";
        options = [ "size=12G" "mode=1777" ];
    };

    # ensure directories exist for systemd not to fail at boot
    systemd.tmpfiles.rules = [
        "d /media 0755 root root -"
        "d /movies 0755 root root -"
        "d /shows 0755 root root -"
    ];

    fileSystems."/media" = {
        device = "10.10.10.20:/mnt/Storage/media";
        fsType = "nfs";
        options = [
            "noauto"
            "x-systemd.automount"
            "nofail"
            "_netdev"
            "nfsvers=4.1"
            "rsize=1048576"
            "wsize=1048576"
            "hard"
            "timeo=600"
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