{ config, pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf osConfig.services.xserver.windowManager.i3.enable {
    programs.i3status-rust = {
      enable = true;
      bars = {
        top = {
          blocks = [
            {
              block = "music";
              player = "spotify";
              format = " $combo.str ";
            }
            {
              block = "net";
              format = " $icon $speed_down.eng(prefix:K,w:3) $speed_up.eng(prefix:K,w:3) $ip {$signal_strength |}";
              interval = 1;
            }
            {
              block = "nvidia_gpu";
              interval = 1;
            }
            {
              block = "memory";
              interval = 1;
            }
            {
              block = "cpu";
              interval = 1;
            }
            {
              block = "temperature";
              interval = 1;
              chip = "*-isa-*";
              format = " $icon $average/$max ";
            }
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              interval = 60;
              warning = 20.0;
              alert = 10.0;
            }
            {
              block = "sound";
              format = " $icon {$volume |}";
            }
            {
              block = "sound";
              format = " $icon {$volume |}";
              device_kind = "source";
            }
            {
              block = "backlight";
              missing_format = "";
            }
            {
              block = "battery";
              interval = 10;
              missing_format = "";
            }
            {
              block = "time";
              interval = 1;
              format = "$timestamp.datetime(f:'%Y-%m-%d %R')";
            }
          ];
          settings = {
            theme =  {
              theme = "plain";
              overrides = {
                idle_bg = "#182030";
                idle_fg = "#edf5ff";
                info_bg = "#182030";
                info_fg = "#edf5ff";
                good_bg = "#182030";
                good_fg = "#edf5ff";
                warning_bg = "#182030";
                warning_fg = "#70b6e5";
                critical_bg = "#182030";
                critical_fg = "#dd3d7d";
                separator_bg = "#182030";
                separator_fg = "#856cd9";
              };
            };
          };
          theme = "plain";
        };
      };
    };
  };
}