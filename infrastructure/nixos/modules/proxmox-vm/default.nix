{ config, pkgs, ... }: {
    imports = [
        ./cloud-init.nix
        ./hardware.nix
    ];
}