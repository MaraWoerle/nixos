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
        alsa-utils # Audio Tools
        acpi
        bat
        bc
        busybox
        brightnessctl
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
        glib
        gparted # Partition Manager
        gtop # Usage screen
        hd-idle # HD-Spindown
        hyfetch # Stats
        imagemagick # Image converter
        lm_sensors # CPU Temp
        lsscsi
        micro # Text Editor
        numlockx # Numlock Control
        openssl
        openssh
        pciutils
        playerctl
        pkg-config
        smartmontools
        spotify-player
        thinkfan # Thinkpad Fan control
        termpdfpy
        tree
        screen
        seatd
        xidlehook # Lock Utility
        xss-lock # Lock Utility
        # XOrg Utils
        xorg.xrandr
        xorg.xrdb
        xorg.xdpyinfo
        xorg.xbacklight
        xorg.xset
      ];
    })
  ];
}
