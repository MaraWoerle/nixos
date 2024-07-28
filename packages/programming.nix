{ config, lib, pkgs, modulesPath, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Programming
    direnv
    doxygen
    getopt
    gnuplot
    lcov
    libGL
    openssl
    pkg-config
    plantuml
  ];

  # Docker
  virtualisation.docker.enable = true;
}
