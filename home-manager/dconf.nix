{ config, pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.gra-env.enable {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-size = 24;
        cursor-theme = "Sweet-cursors";
        enable-animations = true;
        # font-name = "Hack Nerd 10";
        gtk-theme = "rose-pine-moon";
        icon-theme = "Vivid-Dark-Icons";
        gtk-fallback-icon-theme = "oomox-rose-pine-dawn";
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "";
      };
    };
  };
}
