{ config, pkgs, ... }:

{
  imports =
    [
      ./backup.nix
      ./epson.nix
      ./epz-bot.nix
      ./jellyfin.nix
      ./minecraft.nix
      ./nvidia.nix
      ./openssh.nix
      ./plasma.nix
      ./satisfactory.nix
      ./sound.nix
    ];
}
