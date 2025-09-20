{ config, pkgs, ... }: {
    console.keyMap = "sg";
    time.timeZone = "Etc/UTC";
    i18n.defaultLocale = "en_US.UTF-8";
}