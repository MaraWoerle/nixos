{ config, pkgs, lib, ... }:

let
  cfg = config.packages.cpp;
  qt = config.programs.qt;
in

with lib;

{
  options.programs = {
    cpp.enable = mkEnableOption "Enable cpp Support";

    qt.enable = mkEnableOption "Enable the QT editor";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [
        # Programming
        bc
        binutils
        bison
        cmake
        clang-tools
        cppcheck
        conan
        cmake
        elfutils
        flex
        gcc
        gdb
        glibc
        glibc.static
        gnumake
        ncurses
        ninja
        xorg.libX11
        zlib
      ];
    })
    (mkIf (cfg.enable && qt.enable) {
      environment.systemPackages = with pkgs; [
        # Qt
        qtcreator
        qt5.full
        libsForQt5.qmake
        libsForQt5.qt5.qtbase
        libsForQt5.qt5.qttools
        libsForQt5.qt5.qtgamepad
        libsForQt5.qt5.wrapQtAppsHook
        libsForQt5.qt5.qtquickcontrols
        libsForQt5.qt5.qtquickcontrols2
      ];
    })
  ]
}
