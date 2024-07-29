{ cpkgs, ... }:

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
    typescript
    nodePackages.ts-node
    pkg-config
    plantuml
    jdk21
    screen
  ];

  # Docker
  virtualisation.docker.enable = true;
}
