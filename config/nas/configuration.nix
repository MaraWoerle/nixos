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
    args = "-a /dev/disk/by-label/Memory-Alpha -i 1800 -a /dev/disk/by-label/NCC-1764-Archive -i 60 -a /dev/disk/by-label/NCC-2032-Backup -i 60";
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
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
  };

  # File Share
  fileSystems = {
    "/export/DVDs" = {
      device = "/mnt/DVDs";
      options = [ "bind" ];
    };
    "/export/Archive" = {
      device = "/mnt/Archive";
      options = [ "bind" ];
    };
    "/export/Backup" = {
      device = "/mnt/Backup";
      options = [ "bind" ];
    };
  };
  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.1.0/24(insecure,rw,sync,no_subtree_check,crossmnt,fsid=0)
      /export/DVDs 192.168.1.0/24(insecure,rw,sync,no_subtree_check)
      /export/Archive 192.168.1.0/24(insecure,rw,sync,no_subtree_check)
      /export/Backup 192.168.1.0/24(insecure,rw,sync,no_subtree_check)
    '';
  };

  networking.firewall = {
    allowedTCPPorts = [
      # NFS
      2049
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
