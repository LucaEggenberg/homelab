{ config, pkgs, ... }: {
    sops.age.keyFile = [ "/var/lib/sops/keys.txt" ];
}