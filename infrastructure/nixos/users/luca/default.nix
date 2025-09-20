{ config, pkgs, ... }: {
    users.users.luca = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        shell = pkgs.bash;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLTvjhfe4YWatJ3Y19rYj8YHGmiki5AMqDykfkFH5/f"
        ];
    };
}