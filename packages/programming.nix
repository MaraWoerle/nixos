{ pkgs, ... }:

{
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
}
