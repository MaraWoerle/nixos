{ config, pkgs, ... }:

{
  imports =
  [
    ./hardware-configuration.nix
    ../../all.nix
    ../../secrets/searx.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nipogi-server";
  networking.networkmanager.enable = true;

  # Programs
  programs = {
    cli.enable = true;
    programming.enable = true;
    zsh.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Configure console keymap
  console.keyMap = "de";

  # VS-Code Server
  programs.nix-ld.enable = true;

  # HDD Spindown
  services.hd-idle = {
    enable = true;
    args = "-i 60 -a sdc -i 1800 -a sda -i 60";
  };

  # Backup
  local-backup = {
    enable = true;
    directory = "/mnt/Backup";
    disk-uuid = "d07802d5-a0e7-4753-b4a4-ed4a6ce2a891";
    paths = [
      "/home/mara/Documents"
      "/var/lib/satisfactory"
    ];
  };

  # Hamachi
  services.logmein-hamachi.enable = true;

  # SSH
  services.openssh.enable = true;
  users.users.mara.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJPct6O6tX9MTmTRDqWWD/vPvBXMUQvfleu0wuqdaTDG mara@nixos" # Mara-Desktop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqYMfEDTw5VVlmpvC0l9PGjWhmJVsCYoF/VH4XTKhQQ mara@nixos-laptop" # Mara-Laptop
  ];

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "mara";
    dataDir = "/home/mara/Documents";
    configDir = "/home/mara/Documents/.config/syncthing";
    settings = {
      devices = {
        "Mara - Desktop" = { id = "ZWNNQ4G-XMSPHED-VXQJRMO-XF46ALN-5OP7ZWL-G56CCWG-RMFN5C4-PKOHEAI"; };
        "Mara - Handy" = { id = "MXVOA2C-JZGUI2I-PM5GTTA-5OR34QG-VSDF7RO-HA2MRBW-YHWKNG6-HBSGWAS"; };
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
            "Mara - Desktop"
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
            "Mara - Desktop"
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
            "Mara - Desktop"
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
            "Mara - Desktop"
            "Mara - Handy"
            "Mara - Laptop - Leya"
            "Mara - Laptop"
          ];
        };
      };
    };
  };
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 27015 27036 8384 22000 ];
    allowedUDPPorts = [ 69 15777 15000 7777 27015 22000 21027 ];
    allowedUDPPortRanges = [ { from = 27031; to = 27036; } ];
  };

  # Searxng
  services.epz-search = {
    enable = true;
    name = "EPZ-Search";
    envFile = "/run/secrets/searx.env";
    key = "@KEY_EPZ@";
    design-files = /home/mara/Documents/SearXNG;
  };

  # EPZ Bots
  services = {
    epz-bot = {
      # enable = true;
      # directory = "/home/mara/Documents/Discord-Bot/epz-bot";
      db-enable = true;
      db-backup-enable = true;
      db-backup-path = "/home/mara/Documents/Database-Backups";
    };
    epz-test-bot = {
      # enable = true;
      # directory = "/home/mara/Documents/Discord-Bot/epz-test-bot";
      db-enable = true;
      db-backup-enable = true;
    };
  };

  # Minecraft Server
  services.mc-server = {
    enable = true;
    directory = "/home/mara/Documents/Servers/Minecraft/ATM-0";
  };

  # Satisfactory Server
  services.satisfactory.enable = false;

  # Jellyfin
  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  security.rtkit.enable = true;

  # SMB Share
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
    shares = {
      DVDs = {
        path = "/mnt/DVDs";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        writable = "yes";
      };
      Backup = {
        path = "/mnt/Backup";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        writable = "yes";
      };
    };
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mara = {
    isNormalUser = true;
    description = "Mara";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Autologin
  # services.getty.autologinUser = "mara";

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    stateVersion = "24.05";
  };
}
