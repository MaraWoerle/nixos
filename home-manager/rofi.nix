{ config, pkgs, lib, osConfig, ... }:

let
  wm.enable = (osConfig.gra-env.enable && (osConfig.gra-env.env == "i3" || osConfig.gra-env.env == "sway"));
  inherit (config.lib.formats.rasi) mkLiteral;
in

{
  config = lib.mkIf wm.enable {
    programs.rofi = {
      enable = true;
      font = "Hack Nerd Font 12";
      terminal = "kitty";
      theme = "rose-pine-moon";
      extraConfig = {
        modes = "drun,ssh,filebrowser,combi";
        ssh-client = "kitten ssh";
      };
    };
  };
}
