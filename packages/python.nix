{ pkgs, lib, ... }:

let
  cfg = config.programs.python;
in

with lib;

{
  options.packages.python.enable = mkEnableOption "Enable Python support";

  config = mkIf cfg.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Python
      python311
      python311Packages.pip
      python311Packages.numpy
      python311Packages.pillow
    ];
  };
}
