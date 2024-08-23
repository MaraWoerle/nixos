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
        busybox
        dust
        direnv
        doxygen
        figlet
        getopt
        git
        gparted
        gtop
        imagemagick
        lm_sensors
        lsscsi
        makemkv
        openssl
        openssh
        pciutils
        pkg-config
        tree
        screen
      ];
    })
  ];
}
