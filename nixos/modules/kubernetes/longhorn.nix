{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        bash
        curl
        util-linux # for findmnt, blkid, lsblk
        gnugrep
        gawk
        openiscsi
    ];

    services.openiscsi = {
        enable = true;
        name = "iqn.2025-09.com.homelab:p-kube-1";
    };

    # create symlink for iscsiadm so Longhorn can find it
    systemd.tmpfiles.rules = [
        "L+ /usr/bin/iscsiadm - - - - ${pkgs.openiscsi}/bin/iscsiadm"
        "L+ /usr/bin/mount - - - - ${pkgs.util-linux}/bin/mount"
        "L+ /usr/bin/umount - - - - ${pkgs.util-linux}/bin/umount"
    ];
}