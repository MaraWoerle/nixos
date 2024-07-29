{ pkgs, ... }:

{
  imports = [
    ./editors.nix
    ./zsh.nix
  ];

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
