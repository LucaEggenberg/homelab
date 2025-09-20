{ config, pkgs, ... }: {
    # https://docs.k3s.io/installation/requirements#inbound-rules-for-k3s-nodes
    networking.firewall.allowedTCPPorts = [
        6443 # K3s supervisor and Kubernetes API Server
        2379 # Required only for HA with embedded etcd
        2380 # Required only for HA with embedded etcd
    ];

    networking.firewall.allowedUDPPorts = [
        8472 # Required only for Flannel VXLAN
    ];

    services.k3s = {
        enable = true;
        role = "server";
        token = "<randomized common secret>"; # TODO
        serverAddr = "https://10.10.20.20:6443";
    };
}