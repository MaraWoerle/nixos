{ config, pkgs, ... }:

{
  imports = [
    ./i3.nix
    ./i3status.nix
    ./plasma.nix
  ];
}