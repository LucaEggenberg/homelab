{ config, pkgs, ... }: {
  users.users.gitlab = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    description = "gitLab service user";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDSOh0g1coNI859Rqi0739XzXaU9fCH7zxV2UCt5HAIa"
    ];
  };

  security.sudo.extraRules = [{
    users = [ "gitlab" ];
    commands = [{
      command = "/run/current-system/sw/bin/switch-to-configuration";
      options = [ "NOPASSWD" ];
    }];
  }];
}