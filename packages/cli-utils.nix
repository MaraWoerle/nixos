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
        steamcmd
      ];
    })
    (mkIf cfg.enable {
      nixpkgs.config.allowUnfree = true;

      services.gvfs.enable = true;

      environment.systemPackages = with pkgs; [
        # Tools
        acpi
        bat
        busybox
        btop
        cmake
        dust
        direnv
        doxygen
        eza
        figlet
        file
        fzf
        getopt
        git # Version manager
        gparted # Partition Manager
        gtop # Usage screen
        hd-idle # HD-Spindown
        hyfetch # Stats
        imagemagick # Image converter
        lm_sensors # CPU Temp
        lsscsi
        openssl
        openssh
        pciutils
        pkg-config
        smartmontools
        spotify-player
        termpdfpy
        tree
        screen
      ];
    })
  ];
}
