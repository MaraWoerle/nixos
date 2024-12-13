{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./i3.nix
    ./i3status.nix
    ./plasma.nix
    ./sway.nix
  ];
}