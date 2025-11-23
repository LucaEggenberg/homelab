{ config, pkgs, ... }: {
    system.stateVersion = "25.05";
    
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "root" "@wheel" ];
        auto-optimise-store = true;
        require-sigs = false;
    };
    
    nix.package = pkgs.nixVersions.stable;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";
    security.sudo.wheelNeedsPassword = false;
}
