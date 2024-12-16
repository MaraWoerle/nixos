{ config, lib, ... }:

let
  cfg = config.gra-env;
in

with lib;

{
  config = mkIf (cfg.enable && cfg.env == "plasma") {
    # Display Manager
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "de";
          variant = "";
        };
      };
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "plasmax11";
        autoLogin = {
          enable = cfg.autologin;
          user = cfg.autologin-user;
        };
      };
      desktopManager.plasma6.enable = true;
    };
  };
}
