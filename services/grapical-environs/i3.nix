{ pkgs, config, lib, ... }:

let
  cfg = config.gra-env;
in

with lib;

{
  config = mkIf (cfg.enable && cfg.env == "i3") {
    xdg = {
      icons.enable = true;
      mime.enable = true;
    };

    qt = {
      enable = true;
      platformTheme = "gtk2";
      style = "breeze";
    };

    programs.xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
    };

    # Display Manager
    services = {
      picom = {
        enable = true;
        shadow = true;
        settings.corner-radius = 3;
      };

      displayManager = {
        defaultSession = "none+i3";
        sddm = {
          enable = true;
          autoNumlock = true;
          theme = "rose-pine";
        };
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
          cinnamon = {
            extraGSettingsOverrides = ''
              terminal='kitty'
            '';
          };
        };

        displayManager = {
          lightdm.greeters.slick = {
            # enable = true;
          };
        };

        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [
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
          ];
        };
      };

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };
  };
}
