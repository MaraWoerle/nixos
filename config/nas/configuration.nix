{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../all.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only

  networking.hostName = "nixos-nas"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Programs
  programs = {
    cli.enable = true;
    gaming.enable = true;
    programming.enable = true;
    zsh.enable = true;
  };

  # HDD Spindown
  services.hd-idle = {
    enable = true;
    args = "-i 5 -a sdb -i 5 -a sdc -i 5 -a sdd -i 5";
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
  #   font = "Lat2-Terminus16";
    keyMap = "de";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  users.users.mara = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}