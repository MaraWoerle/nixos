{ config, lib, ... }:

let
  cfg = config.plasma;
in

with lib;

{
  options.plasma = {
    enable = mkEnableOption "Enable the plasma display manager";

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