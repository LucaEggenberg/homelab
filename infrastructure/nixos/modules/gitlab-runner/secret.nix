{ config, pkgs, ... }: {
  sops = {
    age.keyFiles = [ "/var/lib/sops/gitlab-runner.agekey" ];

    secrets."gitlab/registration" = {
        sopsFile = ../../secrets/gitlab/registration.yaml; 
    };
  };
}
