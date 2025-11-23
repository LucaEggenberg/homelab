{ config, pkgs, ... }: {
    imports = [
        ./monitoring.nix
        ./networking.nix
        ./ssh.nix
    ];
}