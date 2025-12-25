{ config, pkgs, unstable, lib, ... }: {
  networking.hostName = "v-immich-1";

  imports = [
    ./backups.nix
  ];

  users.groups.immich.gid = 866;
  users.users.immich = {
    isSystemUser = true;
    uid = 866;
    group = "immich";
  };
    
  # Ensure mountpoints exist so systemd doesn’t fail at boot
  systemd.tmpfiles.rules = [
      "d /photos 0755 root root -"
      "d /photos/immich 0755 immich immich -"
  ];
  
  services.immich = {
    enable = true;
    package = unstable.immich;

    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;

    mediaLocation = "/photos/immich";

    machine-learning.enable = true;
    settings = null;

    database.enable = true;
    redis.enable = true;
  };

  fileSystems."/photos" = {
    device = "10.10.10.20:/mnt/Storage/photos";
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
}
