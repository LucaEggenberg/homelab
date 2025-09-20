{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        bash
        curl
        util-linux # for findmnt, blkid, lsblk
        gnugrep
        gawk

    ];

    services.openiscsi = {
        enable = true;
    };

    services.rpcbind.enable = true; # needed for NFS
}