{ config, pkgs, lib, ... }:

let
  cfg = config.programs.python;
in

with lib;

{
  options.programs.python.enable = mkEnableOption "Enable Python support";

  config = mkIf cfg.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Python
      python311Full
      python311Packages.pip
      python311Packages.numpy
      python311Packages.pillow
      python311Packages.tkinter
    ];
  };
}
