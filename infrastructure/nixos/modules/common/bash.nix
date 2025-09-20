{ config, pkgs, ... }: {
    programs.bash = {
        enable = true;

        shellAliases = {
            ".." = "cd ..";
            "..." = "cd ../..";
            vi = "nvim";
            vim = "nvim";
            mkdir = "mkdir -pv";
        };
    };
}