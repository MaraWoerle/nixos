{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.gra-env.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Tools
      arandr # Screen Management
      alacritty # Terminal
      audacity # Audio Editor
      ark # Compressed File Opener
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
      lxde.lxrandr # Monitor Manager
      mission-center # "Task Manager"
      nemo-with-extensions # File Manager
      okular # PDF Viewer
      obs-studio # Streaming Client
      parabolic # Downloader
      pavucontrol # Volume Control
      putty # SSL Client
      themechanger # change GTK Themes
      thunderbird # Email Client
      xsane # Scanning utility
      via # QMK Keyboard programmer
      vlc # Video player
      zapzap # Whatsapp Client
      # Theme Control
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5.qtsvg
      libsForQt5.qt5.qtquickcontrols
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5ct
      # Themes
      rose-pine-gtk-theme
      rose-pine-icon-theme
      rose-pine-cursor
      dracula-icon-theme
      sweet-folders
      sweet
      catppuccin-cursors
      catppuccin-sddm
      tokyonight-gtk-theme
      catppuccin-kvantum
      adwaita-qt
      (callPackage ./sddm-rose-pine.nix {})
      (callPackage ./vivid-dark-icons.nix {})
      (callPackage ./sweet-cursors.nix {})
      mint-themes
      mint-x-icons
      mint-y-icons
    ];

    # VirtualBox
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;

    # QMK & VIA
    hardware.keyboard.qmk.enable = true;
    services.udev.packages = [ pkgs.via ];
  };
}
