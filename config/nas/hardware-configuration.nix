{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "ehci_pci" "ahci" "xhci_pci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/e14100ae-c3d6-495d-a2ae-1f0c4bafb915";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7E5A-A04A";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/mnt/DVDs" =
    { device = "/dev/disk/by-uuid/9ff9415e-6dcf-441c-9cc8-fa0e1bc609b8";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/Archive" =
    { device = "/dev/disk/by-uuid/fbf0f180-6d30-4899-b29e-87a001e91973";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/mnt/Backup" =
    { device = "/dev/disk/by-uuid/6df40d73-3763-495c-bfc6-f6fc5e33a8db";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
