{ config, pkgs, ... }:

{
  imports =
    [
      ./backup.nix
      ./epson.nix
      ./nvidia.nix
      ./plasma.nix
      ./sound.nix
    ];
}
