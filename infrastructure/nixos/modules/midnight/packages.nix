{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        openssl
        pkg-config
    ];
}