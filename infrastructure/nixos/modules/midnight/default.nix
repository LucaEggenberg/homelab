{ config, pkgs, ... }: {
    imports = [
        ./service.nix
        ./packages.nix
    ];
}