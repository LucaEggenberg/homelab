{
    description = "Nix-flake for my nixos servers";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, ... }: 
    let 
        baseModules = [
            ./users/luca
            ./users/gitlab
            ./modules/system
            ./modules/common
            ./modules/server
            inputs.sops-nix.nixosModules.sops
        ];
    in {
        nixosConfigurations = {
            p-kube-1 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/p-kube-1
                    ./modules/kubernetes
                    ./modules/nutclient
                ];
            };
            p-kube-2 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/p-kube-2
                    ./modules/kubernetes
                    ./modules/nutclient
                ];
            };
            p-kube-3 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/p-kube-3
                    ./modules/kubernetes
                    ./modules/nutclient
                ];
            };
            v-gitlab-runner-1 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/v-gitlab-runner-1
                    ./modules/proxmox-vm
                ];
            };
        };
    };
}
