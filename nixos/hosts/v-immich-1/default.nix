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
    "d /mnt/share 0755 root root -"
    "d /mnt/share/photos 0755 immich immich -"

    "d /var/lib/immich 0750 immich immich -"
    "d /var/lib/immich/upload 0750 immich immich -"
    "d /var/lib/immich/thumbs 0750 immich immich -"
    "d /var/lib/immich/encoded-video 0750 immich immich -"
    "d /var/lib/immich/profile 0750 immich immich -"
    "d /var/lib/immich/backups 0750 immich immich -"
    "d /var/lib/immich/library 0755 immich immich -"
  ];
  
  services.immich = {
    enable = true;
    package = unstable.immich;

    host = "0.0.0.0";
    port = 2283;
    openFirewall = true;

    mediaLocation = "/var/lib/immich";

    machine-learning.enable = true;
    settings = null;

    database.enable = true;
    redis.enable = true;
  };

  fileSystems."/mnt/share" = {
    device = "10.10.10.20:/mnt/Storage/applications/immich";
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

  fileSystems."/var/lib/immich/library" = {
    device = "/mnt/share/photos";
    fsType = "none";
    options = [ "bind" "nofail" ];
    depends = [ "/mnt/share" ];
  };

  systemd.services = {
    immich-server.unitConfig.RequiresMountsFor = [ "/var/lib/immich/library" ];
    immich-microservices.unitConfig.RequiresMountsFor = [ "/var/lib/immich/library" ];
  };
}
