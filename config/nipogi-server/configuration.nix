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

  # Backup
  local-backup = {
    enable = true;
    directory = "/mnt/Backup";
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
        "Camera" = {
           id = "hvtbv-u5beb";
           path = "/mnt/Archive/Images/Camera";
           devices = [
             "Mara - Handy"
           ];
         };
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      #27015
      #27036
      #20
      #21
      # Syncthing
      8384
      22000
      # Netboot
      3000
      # NFS
      2049
      # Minecraft
      25565
    ];
    allowedUDPPorts = [
      #15777
      #15000
      #7777
      #27015
      # Syncthing
      22000
      21027
      # Valheim
      2456
      2457
    ];
    # allowedUDPPortRanges = [ { from = 27031; to = 27036; } ];
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
    enable = false;
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

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
  };

  # SMB Share
  fileSystems = {
    "/export/Servers" = {
      device = "/home/mara/Documents/Servers";
      options = [ "bind" ];
    };
  };
  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.1.0/24(insecure,rw,sync,no_subtree_check,crossmnt,fsid=0)
      /export/Servers 192.168.1.0/24(insecure,rw,sync,no_subtree_check)
    '';
  };

  networking = {
    nftables = {
      enable = true;
      ruleset = ''
          table ip nat {
            chain PREROUTING {
              type nat hook prerouting priority dstnat; policy accept;
              iifname "ham0" tcp dport 25565 dnat to 192.168.1.104:25565
            }
          }
      '';
    };
    nat = {
      enable = true;
      internalInterfaces = [ "ham0" ];
      externalInterface = "enp1s0";
      forwardPorts = [
        {
          sourcePort = 25565;
          proto = "tcp";
          destination = "192.168.1.104:25565";
        }
      ];
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mara = {
    isNormalUser = true;
    description = "Mara";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" "hamachi" ];
  };

  services.netboot.enable = true;

  # Autologin
  # services.getty.autologinUser = "mara";

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
    stateVersion = "24.05";
  };
}
