{ config, pkgs, ... }: {
    sops.secrets."nut/password" = {
        sopsFile = ../../secrets/nut/password.yaml; 
    };
}