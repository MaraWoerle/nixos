{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../all.nix
    ];

  programs.adb.enable = true;

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
  sway = {
    enable = true;
    autologin = true;
    autologin-user = "mara";
    blur-method = "gaussian";
  };

  # Backup
  local-backup = {
    enable = true;
    directory = "/mnt/Backup";
    paths = [
      "/home/mara/Pictures"
      "/home/mara/.thunderbird"
      "/home/mara/.mozilla"
    ];
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "mara";
    dataDir = "/home/mara/Documents";    # Default folder for new synced folders
    configDir = "/home/mara/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    settings = {
      devices = {
        "Mara - Server" = { id = "RQ3JSQH-VF652DF-UK2HPUT-GRSWHPQ-CK656WJ-HHVVZ6X-75KTHIN-LASMEAC"; };
        "Mara - Handy" = { id = "JQQ3LWH-7CDIYII-I26J4BD-22ARLTJ-Y3BGB6U-6MOB6EL-VCQDIR6-52AL7QZ"; };
        "Mara - Laptop - Leya" = { id = "NSDSJOJ-QEEUFLC-XIKFRNV-724BSJE-5HYJF27-OMHCPGW-VPRFNSY-6G4TRAW"; };
        "Mara - Laptop" = { id = "O5AZAII-KCE3EQ3-24F3VXC-ML64CBK-CNP4KYF-HO5CPBE-EDQTSHC-LL2BTA7"; };
        "Florian - Desktop" = { id = "WLAE7VU-6O5QO66-V7BPK2B-HOZVREC-ZSEDW3L-ZQSKJFX-UR6TF2S-5KYPJAB"; };
        "Florian - Laptop" = { id = "JCXLTJV-DC4NGW4-WAIKSQJ-ZFG6VUR-SMRGP3F-26ZMZTW-JWEPDF4-KROPJA5"; };
      };
      folders = {
        "1. Semester" = {
          id = "rzwyo-kxwan";
          path = "/home/mara/Documents/1. Semester";
          devices = [
            "Mara - Server"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Laptop"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "2. Semester" = {
          id = "uy11o-5tdi4";
          path = "/home/mara/Documents/2. Semester";
          devices = [
            "Mara - Server"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Laptop"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "3. Semester" = {
          id = "xvssp-3jtck";
          path = "/home/mara/Documents/3. Semester";
          devices = [
            "Mara - Server"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Laptop"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "Syncthing" = {
          id = "qsxxx-h3kqc";
          path = "/home/mara/Documents/Syncthing";
          devices = [
            "Mara - Server"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Laptop"
          ];
        };
      };
    };
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
    extraGroups = [ "networkmanager" "wheel" "docker" "hamachi" "adbusers" ];
    packages = with pkgs; [
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  system = {
    stateVersion = "24.11";
    autoUpgrade.enable = true;
  };
}
