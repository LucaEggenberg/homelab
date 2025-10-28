{ config, pkgs, ... }: {
    sops.secrets."k3s/token" = {
        sopsFile = ../../secrets/kubernetes/k3stoken.yaml; 
    };
}