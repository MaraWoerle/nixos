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

    blur-method = mkOption {
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
        settings.blur = {
          method = cfg.blur-method;
          size = 10;
          deviation = 5.0;
        };
        settings.corner-radius = 3;
      };
      displayManager = {
        defaultSession = "none+i3";
        autoLogin = {
          enable = cfg.autologin;
          user = cfg.autologin-user;
        };
      };
      libinput = {
        enable = true;
        touchpad.naturalScrolling = false;
        mouse = {
          accelProfile = "flat";
          accelSpeed = "-0.1";
        };
      };
      xserver = {
        enable = true;
        xkb = {
          layout = "de";
          variant = "";
        };
        desktopManager = {
          xterm.enable = false;
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
            bc
            betterlockscreen
            brightnessctl
            flameshot
            rofi
            feh
            i3status
            i3lock
            i3lock-color
            i3blocks
            i3-auto-layout
            lm_sensors
            cinnamon.nemo
            numlockx
            pavucontrol
            playerctl
            thinkfan
            xorg.xrandr
            xorg.xrdb
            xorg.xdpyinfo
            xorg.xbacklight
            xorg.xset
            # Themes
            rose-pine-gtk-theme
            rose-pine-icon-theme
            rose-pine-cursor
            sweet-folders
            catppuccin-cursors
            tokyonight-gtk-theme
          ];
        };
      };
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };
  };
}
