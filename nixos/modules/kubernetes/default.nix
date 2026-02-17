{ config, pkgs, ... }: {
    imports = [
        ./k3s.nix
        ./longhorn.nix
        ./nfs.nix
        ./secret.nix
    ];
}