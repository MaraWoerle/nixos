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
    direnv
    doxygen
    figlet
    getopt
    git
    gparted
    openssl
    pciutils
    pkg-config
    tree
    steamPackages.steamcmd
    screen
  ];
}
