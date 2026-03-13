{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nfs-utils
  ];

  networking.firewall = {
    allowedTCPPorts = [ 2049 ];
    allowedUDPPorts = [ 2049 111 ];
  };

  services.rpcbind.enable = true;

  systemd.tmpfiles.rules = [
        "L+ /sbin/mount.nfs - - - - ${pkgs.nfs-utils}/bin/mount.nfs"
        "L+ /sbin/mount.nfs4 - - - - ${pkgs.nfs-utils}/bin/mount.nfs4"
    ];
}