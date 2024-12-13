{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf (config.plasma.enable || config.programs.hyprland.enable || config.i3.enable || config.sway.enable) {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Tools
      audacity # Audio Editor
      blender # 3D Software
      brave # Chromium-Browser
      davinci-resolve # Video Editor
      ffmpeg
      filezilla # Remote File Explorer
      firefox # Browser
      geany # Text Editor
      geeqie # Image Viewer
      gimp # Image Editor
      github-desktop # Github Desktop
      handbrake # Video Encoder
      inkscape # Image Editor
      keepassxc # Password Manager
      qalculate-gtk # Calculator
      krita # Image Editor
      kitty # Terminal
      libreoffice # Office Suite
      librewolf # Browser
      lxappearance # Theme changer
      logseq # Markdown Notes App
      mission-center # "Task Manager"
      okular # PDF Viewer
      obs-studio # Streaming Client
      parabolic # Downloader
      putty # SSL Client
      themechanger # change GTK Themes
      thunderbird # Email Client
      xsane # Scanning utility
      via # QMK Keyboard programmer
      vlc # Video player
      zapzap # Whatsapp Client
    ];

    # VirtualBox
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;

    # QMK & VIA
    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
