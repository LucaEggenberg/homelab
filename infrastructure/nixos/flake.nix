{
    description = "Nix-flake for my nixos servers";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        inputs.sops-nix = {
            url = "github:Mic92/sops-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, ... }: 
    let 
        baseModules = [
            ./modules/system
            ./modules/common
            ./modules/server
        ];
    in {
        nixosConfigurations = {
            kube1 = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit self nixpkgs };
                modules = baseModules ++ [
                    ./hosts/kube1
                    ./modules/kubernetes
                    inputs.sops-nix.nixosModules.sops
                ];
            };
        };
    };
}