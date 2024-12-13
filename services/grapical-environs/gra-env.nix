{ pkgs, config, lib, ... }:

let
  cfg = config.gra-env;
in

with lib;

{
  options.gra-env = {
    enable = mkEnableOption "Enable the Graphical Environment";

    env = mkOption {
      default = "";
      type = with types; uniq str;
    };

    autologin = mkOption {
      default = false;
      type = with types; bool;
    };

    autologin-user = mkOption {
      default = "";
      type = with types; uniq str;
    };
  };

  imports =
    [
      ./i3.nix
      ./plasma.nix
      ./sway.nix
    ];
}
