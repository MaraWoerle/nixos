{ pkgs, config, lib, ... }:

let
  cfg = config.i3;
in

with lib;

{
  options.i3 = {
    enable = mkEnableOption "Enable the i3 window manager";

    autologin = mkOption {
      default = false;
      type = with types; bool;
    };

    autologin-user = mkOption {
      default = "";
      type = with types; uniq str;
    };
  };

  config = mkIf cfg.enable {
    # Display Manager
    services = {
      picom = {
        enable = true;
        shadow = true;
      };
      displayManager = {
        defaultSession = "none+i3";
        autoLogin = {
          enable = cfg.autologin;
          user = cfg.autologin-user;
        };
      };
      xserver = {
        enable = true;
        xkb = {
          layout = "de";
          variant = "";
        };
        libinput = {
          enable = true;
          touchpad.naturalScrolling = false;
        };
        desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = false;
            noDesktop = true;
            enableXfwm = false;
          };
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            brightnessctl
            flameshot
            rofi
            feh
            i3status
            i3lock
            i3blocks
            lm_sensors
            numlockx
            playerctl
            thinkfan
          ];
        };
      };
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };
  };
}
