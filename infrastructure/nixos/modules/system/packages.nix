{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        git
        neovim
        curl
    ];
}
