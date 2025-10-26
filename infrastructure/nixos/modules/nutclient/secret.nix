{ config, pkgs, ... }: {
    sops = {
        age.keyFiles = [ "/var/lib/sops/nut-clients.agekey" ];

        secrets."nut/password" = {
            sopsFile = ../../secrets/nut/password.yaml; 
        };   
    };
}