{ config, pkgs, lib, ... }:

let
  cfg = config.programs.cli;
in

with lib;

{
  options.programs.cli.enable = mkEnableOption "Enable CLI Tools";

  config = mkMerge [
    (mkIf (config.programs.steam.enable && cfg.enable) {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        steamPackages.steamcmd
      ];
    })
    (mkIf cfg.enable {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        # Tools
        direnv
        doxygen
        figlet
        getopt
        git
        gparted
        imagemagick
        lm_sensors
        openssl
        pciutils
        pkg-config
        tree
        screen
      ];
    })
  ];
}
