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
            cinnamon.nemo
            numlockx
            pavucontrol
            playerctl
            libsForQt5.qt5.qtsvg
            libsForQt5.qt5.qtquickcontrols
            libsForQt5.qt5.qtgraphicaleffects
            qt5ct
            thinkfan
            xidlehook
            xorg.xrandr
            xorg.xrdb
            xorg.xdpyinfo
            xorg.xbacklight
            xorg.xset
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
          ];
        };
      };
      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };
  };
}
