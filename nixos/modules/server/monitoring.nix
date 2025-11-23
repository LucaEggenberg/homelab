{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        prometheus-node-exporter
    ];

    # WIP
}