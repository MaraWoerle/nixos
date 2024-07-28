{ config, lib, pkgs, modulesPath, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Tools
    figlet
    git
    gparted
    pciutils
    tree
    steamPackages.steamcmd
  ];
}
