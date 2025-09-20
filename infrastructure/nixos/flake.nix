{
    description = "Nix-flake for my nixos servers";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
                ];
            };
        };
    };
}