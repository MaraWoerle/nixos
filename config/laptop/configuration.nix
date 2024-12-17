{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../all.nix
      ../../secrets/networks.nix
    ];

  fonts.packages = with pkgs; [
    encode-sans
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  # Printer
  epson ={
    enable = true;
    ip-address = "192.168.1.100";
  };

  # Fan Control
  services.thinkfan.enable = true;

  gra-env = {
    enable = true;
    env = "sway";
    autologin = true;
    autologin-user = "mara";
  };

  amd.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos-laptop"; # Define your hostname.
    wireless = {
      enable = true;
      userControlled.enable = true;
      secretsFile = "/run/secrets/wireless.env";
      networks = {
        "I.M.P Staff".pskRaw = "ext:PSK_IMP";
        "BI-YH 262".psk = "ext:PSK_BIYH262";
        "Kiwifi".psk = "ext:PSK_KIWIFI";
        "Motorola Edge".psk = "ext:PSK_MOTOROLAEDGE";
        "eduroam".auth = ''
          key_mgmt=WPA-EAP
          eap=PEAP
          identity="ext:USER_EDUROAM"
          password="ext:PSK_EDUROAM"
        '';
        "FRITZ!Box 7530 FM".psk = "ext:PSK_FRITZBOX7530";
      };
    };
  };

  programs = {
    cli.enable = true;
    programming.enable = true;
    python.enable = true;
    gaming.enable = true;
    zsh.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  services.syncthing = {
    enable = true;
    user = "mara";
    dataDir = "/home/mara/Documents";
    configDir = "/home/mara/Documents/.config/syncthing";
    settings = {
      devices = {
        "Mara - Desktop" = { id = "ZWNNQ4G-XMSPHED-VXQJRMO-XF46ALN-5OP7ZWL-G56CCWG-RMFN5C4-PKOHEAI"; };
        "Mara - Handy" = { id = "JQQ3LWH-7CDIYII-I26J4BD-22ARLTJ-Y3BGB6U-6MOB6EL-VCQDIR6-52AL7QZ"; };
        "Mara - Laptop - Leya" = { id = "NSDSJOJ-QEEUFLC-XIKFRNV-724BSJE-5HYJF27-OMHCPGW-VPRFNSY-6G4TRAW"; };
        "Mara - Server" = { id = "RQ3JSQH-VF652DF-UK2HPUT-GRSWHPQ-CK656WJ-HHVVZ6X-75KTHIN-LASMEAC"; };
        "Florian - Desktop" = { id = "WLAE7VU-6O5QO66-V7BPK2B-HOZVREC-ZSEDW3L-ZQSKJFX-UR6TF2S-5KYPJAB"; };
        "Florian - Laptop" = { id = "JCXLTJV-DC4NGW4-WAIKSQJ-ZFG6VUR-SMRGP3F-26ZMZTW-JWEPDF4-KROPJA5"; };
      };
      folders = {
        "1. Semester" = {
          id = "rzwyo-kxwan";
          path = "/home/mara/Documents/1. Semester";
          devices = [
            "Mara - Desktop"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Server"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "2. Semester" = {
          id = "uy11o-5tdi4";
          path = "/home/mara/Documents/2. Semester";
          devices = [
            "Mara - Desktop"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Server"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "3. Semester" = {
          id = "xvssp-3jtck";
          path = "/home/mara/Documents/3. Semester";
          devices = [
            "Mara - Desktop"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Server"
            "Florian - Desktop"
            "Florian - Laptop"
          ];
        };
        "Syncthing" = {
          id = "qsxxx-h3kqc";
          path = "/home/mara/Documents/Syncthing";
          devices = [
            "Mara - Desktop"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Server"
          ];
        };
      };
    };
  };

  console.keyMap = "de";

  users.users.mara = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh.enable = true;

  system.stateVersion = "24.11";
}

