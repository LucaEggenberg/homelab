{ ... }: {
    networking.hostName = "p-kube-1";
    
    imports = [
        ./hardware-configuration.nix
    ];
}