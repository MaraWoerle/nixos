{ config, lib, pkgs, ... }:

let
  cfg = config.epson;
in

with lib;

{
  options.epson = {
    enable = mkEnableOption "Enable printing with epson";

    ip-address = mkOption {
      type = with types; uniq str;
      description = ''
        IP of the printer
      '';
    };
  };

  config = mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = [
        pkgs.epson-escpr
        pkgs.epson-escpr2
        pkgs.epkowa
      ];
    };
    # Epson Drivers
    hardware.sane = {
      enable = true;
      extraBackends = [
        pkgs.epson-escpr
        pkgs.epson-escpr2
        pkgs.epkowa
        pkgs.epsonscan2
      ];
    };
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    networking.firewall.extraCommands = ''
      iptables -A INPUT -s ${cfg.ip-address} -j ACCEPT
      iptables -A OUTPUT -d  ${cfg.ip-address} -j ACCEPT
    '';
  };
}
