{ config, pkgs, ... }: {
    imports = [
        ./bash.nix
        ./locale.nix
        ./sops.nix
    ];
}