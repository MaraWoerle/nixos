{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = config.amd;
in

with lib;

{
  options.amd = {
    enable = mkEnableOption "Enable AMD Drivers";
  };

  config = mkIf cfg.enable {
    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
