{ config, pkgs, ... }:

{
  imports = [
    ./cli-utils.nix
    ./cpp.nix
    ./editors.nix
    ./gaming.nix
    ./nano.nix
    ./programming.nix
    ./python.nix
    ./utils.nix
    ./zsh.nix
  ];
}
