{ config, lib, pkgs, ... }:

let
  cfg = config.services.dailys;
in

with lib;

{
  options.services.dailys = {
    enable = mkEnableOption "Enable the Commit Service";

    directory = mkOption {
      type = with types; uniq str;
      description = ''
        Directory of the script.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.dailys = {
      description = "Daily-Service";
      wantedBy = ["timers.target"];
      unitConfig = {
        RequiresMountsFor = "${cfg.directory}";
      };
      serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = "${cfg.directory}";
          ExecStart = "/run/current-system/sw/bin/sh start.sh";
          User = "root";
      };
    };
    systemd.timers.commits = {
      wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "commits.service";
        };
    };
  };
}
