{ config, pkgs, ... }: {
    imports = [
        ./k3s.nix
        ./packages.nix
    ];
}