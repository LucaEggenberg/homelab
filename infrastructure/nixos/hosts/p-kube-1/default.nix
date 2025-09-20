{ ... }: {
    networking.hostname = "p-kube-1";

    sops = {
        age.sshKeyPaths = [ "/etc/ssh/id_ed25519" ];

        secrets."k3s/token" = {
            sopsFile = ../../secrets/k3s.yaml;
            key = "k3s.token";
        };
    };
}