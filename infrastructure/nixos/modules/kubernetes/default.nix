{ config, pkgs, ... }: {
    imports = [
        ./k3s.nix
        ./longhorn.nix
        ./secret.nix
    ];
}