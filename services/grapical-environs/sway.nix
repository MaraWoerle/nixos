{ pkgs, config, lib, ... }:

let
  cfg = config.sway;
in

with lib;

{
  options.sway = {
    enable = mkEnableOption "Enable the sway window manager";

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
    security = {
      rtkit.enable = true;
      polkit.enable = true;
    };

    xdg = {
      icons.enable = true;
      mime.enable = true;
      portal = {
        enable = true;
        wlr.enable = true;
      };
    };

    programs.xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
    };

    # Display Manager
    services = {
      dbus.enable = true;
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
        #defaultSession = "sway";
        sddm = {
          enable = true;
          autoNumlock = true;
          theme = "rose-pine";
        };
        # autoLogin = {
        #   enable = cfg.autologin;
        #   user = cfg.autologin-user;
        # };
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
      };

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };

    programs.sway = {
      enable = true;
      # package = pkgs.swayfx;
      extraOptions = [ "--unsupported-gpu" ];
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
    };

    #environment.loginShellInit = ''
    #  sway --unsupported-gpu
    #'';

    environment.systemPackages = with pkgs; [
      alsa-utils
      arandr
      alacritty
      ark
      bc
      betterlockscreen
      brightnessctl
      flameshot
      feh
      glib
      i3status
      lm_sensors
      lxappearance
      lxde.lxrandr
      libsForQt5.qtstyleplugin-kvantum
      micro
      nemo-with-extensions # File Manager
      numlockx
      pavucontrol # Volume Control
      playerctl
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtquickcontrols
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5ct
      seatd
      swaybg
      thinkfan
      xidlehook
      xorg.xrandr
      xorg.xrdb
      xorg.xdpyinfo
      xorg.xbacklight
      xorg.xset
      xss-lock
      wofi # Application launcher
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
}
