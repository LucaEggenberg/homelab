{ config, pkgs, ... }: {
    programs.bash.shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        vi = "nvim";
        vim = "nvim";
        mkdir = "mkdir -pv";
    };
}