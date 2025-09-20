{ config, pkgs, ... }: {
    networking.firewall.allowedTCPPorts = [
        443
        80
    ];
}