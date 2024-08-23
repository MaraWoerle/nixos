{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = config.nvidia;
in

with lib;

{
  options.nvidia = {
    enable = mkEnableOption "Enable Nvidia Drivers";
  };

  config = mkIf cfg.enable {
    # Boot Driver
    boot.initrd.kernelModules = [ "nvidia" ];
    boot.extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];

    # Enable OpenGL
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    # Docker support
    hardware.nvidia-container-toolkit.enable = true;

    # Load nvidia driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {

      # Modesetting is required.
      modesetting.enable = true;

      # Nvidia power management.
      powerManagement.enable = false;

      # Fine-grained power management.
      powerManagement.finegrained = false;

      # Use the NVidia open source kernel module
      open = false;

      # Enable the Nvidia settings menu,
      # accessible via `nvidia-settings`.
      nvidiaSettings = true;

      # Reduce Screen Tearing
      forceFullCompositionPipeline = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
