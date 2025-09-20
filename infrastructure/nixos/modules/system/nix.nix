{ config, pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.package = pkgs.nixVersions.stable;
    nix.settings.auto-optimise-store = true;
    nix.gc.automatic = true;
    nix.gc.dates = "weekly";
    nix.gc.options = "--delete-older-than 7d";
}
