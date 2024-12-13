{ pkgs, config, lib, ... }:

let
  cfg = config.gra-env;
in

with lib;

{
  config = mkIf (cfg.enable && cfg.env = "i3") {
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
        settings.blur = {
          method = cfg.blur-method;
          size = 10;
          deviation = 5.0;
        };
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
            arandr
            alacritty
            ark
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
            lxappearance
            lxde.lxrandr
            libsForQt5.qtstyleplugin-kvantum
            micro
            nemo-with-extensions # File Manager
            numlockx
            pavucontrol
            playerctl
            libsForQt5.qt5.qtsvg
            libsForQt5.qt5.qtquickcontrols
            libsForQt5.qt5.qtgraphicaleffects
            libsForQt5.qt5ct
            thinkfan
            xidlehook
            xorg.xrandr
            xorg.xrdb
            xorg.xdpyinfo
            xorg.xbacklight
            xorg.xset
            xss-lock
            # Themes
            rose-pine-gtk-theme
            rose-pine-icon-theme
            rose-pine-cursor
            dracula-icon-theme
            sweet-folders
            sweet
            catppuccin-cursors
            catppuccin-sddm
            tokyonight-gtk-theme
            catppuccin-kvantum
            adwaita-qt
            (callPackage ../packages/sddm-rose-pine.nix {})
            (callPackage ../packages/vivid-dark-icons.nix {})
            (callPackage ../packages/sweet-cursors.nix {})
            mint-themes
            mint-x-icons
            mint-y-icons
          ];
        };
      };

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };
  };
}
