{ config, lib, pkgs, modulesPath, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Python
    python311
    python311Packages.pip
    python311Packages.numpy
    python311Packages.pillow
  ];
}
