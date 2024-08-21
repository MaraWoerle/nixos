{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf (config.plasma.enable || config.programs.hyprland.enable) {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Tools
      anydesk
      audacity
      blender
      brave
      davinci-resolve
      ffmpeg
      filezilla
      firefox
      gimp
      github-desktop
      handbrake
      inkscape
      keepassxc
      kcalc
      krita
      kitty
      libreoffice
      logseq
      putty
      spotify
      thunderbird
      xsane
      via
      vlc
      zapzap
    ];

    # VirtualBox
    virtualisation.virtualbox.host.enable = true;

    # QMK & VIA
    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
