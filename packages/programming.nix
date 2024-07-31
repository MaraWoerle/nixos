{ config, pkgs, lib, ... }:

let
  cfg = config.programs.programming;
in

with lib;

{
  options.programs.programming.enable = mkEnableOption "Enable programming Packages";

  config = mkIf cfg.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Programming
      gnuplot
      lcov
      libGL
      typescript
      nodePackages.ts-node
      plantuml
      jdk21
    ];

    # Docker
    virtualisation.docker.enable = true;
  };
}
