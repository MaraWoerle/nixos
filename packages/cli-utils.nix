{ pkgs, lib, ... }:

let
  cfg = config.packages.cli;
in

with lib;

{
  options.packages.cli.enable = mkEnableOption "Enable CLI Tools";

  config = mkMerge [
    (mkIf (config.programs.steam.enable && cfg.enable) {
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        steamPackages.steamcmd
      ];
    })
    (mkIf cfg.enable {
      imports = [
        ./editors.nix
        ./zsh.nix
      ];

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
        screen
      ];
    })
  ];
}
