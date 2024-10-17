{ config, lib, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ../../all.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelPackages = (import (builtins.fetchTarball https://gitlab.com/vriska/nix-rpi5/-/archive/main.tar.gz)).legacyPackages.aarch64-linux.linuxPackages_rpi5;

  networking.hostName = "nixos-raspi"; # Define your hostname.
  # Pick only one of the below networking options.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Programs
  programs = {
    cli.enable = true;
    programming.enable = true;
    zsh.enable = true;
  };

  # Keymaps
  console.keyMap = "de";

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # SSH
  services.openssh.enable = true;
  users.users.mara.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPct6O6tX9MTmTRDqWWD/vPvBXMUQvfleu0wuqdaTDG mara@nixos"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqYMfEDTw5VVlmpvC0l9PGjWhmJVsCYoF/VH4XTKhQQ mara@nixos-laptop"
  ];

  # VS Code Server
  programs.nix-ld.enable = true;

  # Technitium
  services.technitium-dns-server = {
    enable = true;
    openFirewall = true;
  };

  # Commits
  services.dailys = {
    enable = true;
    directory = "/home/mara/Commits";
  };

  # EPZ Bots
  services = {
    epz-bot = {
      enable = true;
      directory = "/home/mara/Discord-Bot/epz-bot";
    };
    epz-test-bot = {
      enable = true;
      directory = "/home/mara/Discord-Bot/epz-test-bot";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mara = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    ];
  };

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    stateVersion = "24.05";
  };
}
