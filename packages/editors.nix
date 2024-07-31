{ pkgs, lib, ... }:

with lib;

{
  config = mkMerge [
    ({
      imports = [
        ./nano.nix
      ];
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
