{ ... }: {
    networking.hostName = "v-gitlab-runner-1";
    
    imports = [
        ./hardware-configuration.nix
    ];
}