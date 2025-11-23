{ ... }: {
    networking.hostName = "p-kube-2";
    
    imports = [
        ./hardware-configuration.nix
    ];
}