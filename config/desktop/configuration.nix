{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../all.nix
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Programs
  programs = {
    cli.enable = true;
    cpp.enable = true;
    qt.enable = true;
    gaming.enable = true;
    programming.enable = true;
    python.enable = true;
    zsh.enable = true;
  };

  # Nvidia Drivers
  nvidia.enable = true;

  # Hyprland
  # programs.hyprland.enable = true;

  # WM
  i3 = {
    enable = true;
    autologin = true;
    autologin-user = "mara";
    blur-method = "gaussian";
  };

  # Sound
  sound.enable = true;

  # Backup
  local-backup = {
    enable = true;
    directory = "/mnt/Backup";
    disk-uuid = "0c1f82b9-ab2e-4552-86f8-abf862726ec2";
    paths = [
      "/home/mara/Documents"
      "/home/mara/Pictures"
      "/home/mara/.thunderbird"
      "/home/mara/.config"
      "/home/mara/.mozilla"
      "/home/mara/.ssh"
      "/home/mara/.anydesk"
      "/home/mara/.gitconfig"
      "/etc/nixos"
    ];
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "mara";
    dataDir = "/home/mara/Documents";    # Default folder for new synced folders
    configDir = "/home/mara/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
  };

  # Epson
  epson ={
    enable = true;
    ip-address = "192.168.1.100";
  };

  # Configure console keymap
  console.keyMap = "de";

  # User Account
  users.users.mara = {
    isNormalUser = true;
    description = "Mara";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  system = {
    stateVersion = "24.05";
    autoUpgrade.enable = true;
  };
}
