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
            ./modules/system
            ./modules/common
            ./modules/server
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
                    inputs.sops-nix.nixosModules.sops
                ];
            };
            p-kube-2 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/p-kube-2
                    ./modules/kubernetes
                    ./modules/nutclient
                    inputs.sops-nix.nixosModules.sops
                ];
            };
            p-kube-3 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs; };
                modules = baseModules ++ [
                    ./hosts/p-kube-3
                    ./modules/kubernetes
                    ./modules/nutclient
                    inputs.sops-nix.nixosModules.sops
                ];
            };
        };
    };
}