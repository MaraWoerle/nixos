{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    ./nano.nix
  ];

  config = mkMerge [
    ({
      environment.systemPackages = with pkgs; [
        # Editors and IDEs
        emacs
        nano
        vim
      ];
    })
    (mkIf config.plasma.enable {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        # Editors and IDEs
        jetbrains.clion
        vscode
      ];
    })
  ];
}
