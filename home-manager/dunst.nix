{ config, pkgs, lib, osConfig, ... }:

let
  modifier = config.xsession.windowManager.i3.config.modifier;
in

{
  config = lib.mkIf osConfig.services.xserver.windowManager.i3.enable {
    services.dunst = {
      enable = true;
    };
  };
}
