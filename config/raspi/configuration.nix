{ config, lib, pkgs, inputs, ... }:

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
  # raspberry-pi-nix.board = "bcm2712";
  boot.kernelPackages = (import (builtins.fetchTarball {
    url = "https://gitlab.com/vriska/nix-rpi5/-/archive/main.tar.gz";
    sha256 = "sha256:12110c0sbycpr5sm0sqyb76aq214s2lyc0a5yiyjkjhrabghgdcb";
  })).legacyPackages.aarch64-linux.linuxPackages_rpi5;

  networking = {
    hostName = "nixos-raspi"; # Define your hostname.
    interfaces.end0.ipv4.addresses = [{
      address = "192.168.1.105";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.1.1";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

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
    firewallTCPPorts = [
      53
      5380
      53443
    ];
    firewallUDPPorts = [
      53
      67
      68
    ];
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
