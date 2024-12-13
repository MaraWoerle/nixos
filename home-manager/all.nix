{ config, pkgs, ... }:

{
  imports = [
    ./dunst.nix
    ./dconf.nix
    ./i3.nix
    ./i3status.nix
    ./plasma.nix
    ./sway.nix
  ];
}