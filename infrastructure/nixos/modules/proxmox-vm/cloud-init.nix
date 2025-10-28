{ config, pkgs, lib, ... }: {
  environment.systemPackages = [ pkgs.cloud-init ];
  
  services.cloud-init.enable = true;
  services.cloud-init.network.enable = true;

  services.cloud-init.config = ''
    datasource_list: [ NoCloud, ConfigDrive ]
  '';

  systemd.network.enable = true;
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  services.qemuGuest.enable = true;

  boot.initrd.availableKernelModules = [
    "sr_mod"
    "cdrom"
    "isofs"
    "virtio_pci"
    "virtio_blk"
    "virtio_scsi"
  ];
  boot.kernelModules = [
    "sr_mod"
    "cdrom"
    "isofs"
  ];

  users.mutableUsers = true;
}
