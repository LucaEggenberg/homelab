{ ... }: {
    networking.hostName = "p-kube-1";
    
    imports = [
        ./hardware-configuration.nix
    ];

    sops = {
        age.sshKeyPaths = [ "/etc/ssh/id_ed25519" ];

        secrets."k3s/token" = {
            sopsFile = ../../secrets/kubernetes/k3s.yaml;
        };
    };
}