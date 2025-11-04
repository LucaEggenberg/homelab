{ config, pkgs, ... }: {
    networking.hostName = "p-midnight-1";

    imports = [
        ./hardware-configuration.nix
    ];
}