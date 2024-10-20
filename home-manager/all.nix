{ config, pkgs, ... }:

{
  imports = [
    ./i3/all.nix
    ./plasma.nix
  ];
}