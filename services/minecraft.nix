{ config, lib, pkgs, ... }:

let
  cfg = config.services.mc-server;
in

with lib;

{
  options = {
    services.mc-server = {
      enable = mkEnableOption "Enable the Server.";

      directory = mkOption {
        type = with types; uniq str;
        description = ''
          Directory of the Server.
        '';
      };

      port = mkOption {
        default = 25565;
        type = with types; int;
        description = ''
          Port of the Server.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.minecraft = {
      description = "Minecraft Server";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target"];
      unitConfig = {
        RequiresMountsFor = "${cfg.directory}";
      };
      serviceConfig = {
          Type = "forking";
          Restart = "always";
          RestartSec = 1;
          WorkingDirectory = "${cfg.directory}";
          ExecStart = "/run/current-system/sw/bin/sh start.sh";
          ExecStop = "/run/current-system/sw/bin/sh stop.sh";
      };
    };
    networking.firewall = {
      allowedTCPPorts = [ cfg.port ];
      allowedUDPPorts = [ cfg.port ];
    };
    environment.systemPackages = with pkgs; [
      jdk21
    ];
  };
}
