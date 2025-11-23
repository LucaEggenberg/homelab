{ ... }: {
    networking.hostName = "p-kube-3";
    
    imports = [
        ./hardware-configuration.nix
    ];
}