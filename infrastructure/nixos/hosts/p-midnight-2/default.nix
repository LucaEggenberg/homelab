{ config, pkgs, ... }: {
    networking.hostName = "p-midnight-2";

    imports = [
        ./hardware-configuration.nix
    ];
}