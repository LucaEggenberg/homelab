{ config, pkgs, ... }: {
    networking.hostName = "v-gitlab-runner-1";

    users.groups.gitlab-runner = {};
    users.users.gitlab-runner = {
        isSystemUser = true;
        group = "gitlab-runner";
        description = "gitlab-runner user";
    };

    sops.secrets."registration" = {
        sopsFile = ../../secrets/gitlab/registration.env;
        format = "dotenv";
        mode = "0400";
        owner = "gitlab-runner";
        group = "gitlab-runner";
    };

    boot.kernel.sysctl."net.ipv4.ip_forward" = true; # 1
    virtualisation.docker.enable = true;
    virtualisation.docker.autoPrune.enable = true;

    services.gitlab-runner = {
        enable = true;
        settings.concurrent = 2;

        services = {
            nix = {
                authenticationTokenConfigFile = config.sops.secrets."registration".path;
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