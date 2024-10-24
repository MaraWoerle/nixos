{ config, pkgs, lib, osConfig, ... }:

let
  modifier = config.xsession.windowManager.i3.config.modifier;
in

{
  config = lib.mkIf osConfig.services.xserver.windowManager.i3.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          browser = "${config.programs.firefox.package}/bin/firefox -new-tab";
          dmenu = "${pkgs.rofi}/bin/rofi -dmenu";

          width = "(0, 400)";
          offset = "(5, 10)";

          progress_bar_min_width = 380;
          progress_bar_max_width = 380;
          progress_bar_corner_radius = 3;
          progress_bar_horizontal_alignement = "center";

          padding = 10;
          horizontal_padding = 10;

          frame_width = 3;
          corner_radius = 3;
          gap_size = 3;

          markup = "full";
          follow = "mouse";
          font = "Hack Nerd 10";

          icon_theme = "rose-pine-icons";
          enable_recursive_icon_lookup = true;
          notification_limit = 3;
          origin = "top-center";

          background = "#393552";
          foreground = "#e0def4";
        };

        urgency_low = {
          background = "#393955";
          foreground = "#3e8fb0";
          frame_color = "#3e8fb0";
        };

        urgency_normal = {
          background = "#443c53";
          foreground = "#f6c177";
          frame_color = "#f6c177";
        };

        urgency_critical = {
          background = "#433754";
          foreground = "#eb6f92";
          frame_color = "#eb6f92";
        };

      };
    };
  };
}
