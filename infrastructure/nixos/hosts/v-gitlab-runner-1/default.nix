{ config, pkgs, ... }: {
    networking.hostName = "v-gitlab-runner-1";

    sops.secrets."gitlab/registration" = {
        sopsFile = ../../secrets/gitlab/registration.yaml; 
    };

    boot.kernel.sysctl."net.ipv4.ip_forward" = true; # 1
    virtualisation.docker.enable = true;
    virtualisation.docker.autoPrune.enable = true;

    services.gitlab-runner = {
        enable = true;
        concurrent = 2;

        services = {
            nix = {
                registrationConfigFile = config.sops.secrets."gitlab/registration".path;
                dockerImage = "nixos/nix:latest";
                dockerVolumes = [
                "/nix/store:/nix/store:ro"
                "/nix/var/nix/db:/nix/var/nix/db:ro"
                "/nix/var/nix/daemon-socket:/nix/var/nix/daemon-socket:ro"
                "/tmp:/tmp"
                ];

                dockerDisableCache = true;
                tagList = [ "nix" ];
                runUntagged = true;
            };
        };
    };
}