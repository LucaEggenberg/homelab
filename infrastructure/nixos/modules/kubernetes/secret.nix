{ config, pkgs, ... }: {
    sops = {
        age.keyFiles = [ "/var/lib/sops/kubernetes-nodes.agekey" ];

        secrets."k3s/token" = {
            sopsFile = ../../secrets/kubernetes/k3stoken.yaml; 
        };   
    };
}