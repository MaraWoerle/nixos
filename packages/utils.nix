{ pkgs, ... }:

{
  imports = [
    ./cli-utils.nix
  ];

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
    libreoffice
    logseq
    putty
    spotify
    thunderbird
    xsane
    vlc
    zapzap
  ];

  # VirtualBox
  virtualisation.virtualbox.host.enable = true;

  # QMK & VIA
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];
}
