{ pkgs, config, lib, ... }:

let
  cfg = config.gra-env;
in

with lib;

{
  config = mkIf (cfg.enable && cfg.env == "sway") {
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

    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "cleanlooks";
    };

    environment.variables = {
      QT_STYLE_OVERRIDE = "cleanlooks";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_QPA_PLATFORM = "wayland";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
    };

    # Display Manager
    services = {
      dbus.enable = true;

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
      };

      gvfs.enable = true;
      gnome.gnome-keyring.enable = true;
      blueman.enable = true;
    };

    programs.sway = {
      enable = true;
      extraOptions = [ "--unsupported-gpu" ];
      wrapperFeatures.gtk = true;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      i3status
      grimblast # Screenshot Utility
      swaybg
      wofi # Application launcher
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      libsForQt5.breeze-icons
    ];
  };
}
