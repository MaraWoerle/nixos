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
      nodejs
      typescript
      texlive.combined.scheme-full
      nodePackages.ts-node
      plantuml
      jdk21
      jdk8
      vscode
      # Rust
      rustc
      cargo
    ];

    # Docker
    virtualisation.docker.enable = true;
  };
}
