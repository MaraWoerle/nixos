{ config, lib, pkgs, ... }:

let
  cfg = config.services.commits;
in

with lib;

{
  options.services.commits = {
    enable = mkEnableOption "Enable the Commit Service";

    directory = mkOption {
      type = with types; uniq str;
      description = ''
        Directory of the script.
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.commits = {
      description = "Commit-Service";
      wantedBy = ["timers.target"];
      unitConfig = {
        RequiresMountsFor = "${cfg.directory}";
      };
      serviceConfig = {
          Type = "oneshot";
          WorkingDirectory = "${cfg.directory}";
          ExecStart = "/run/current-system/sw/bin/sh commit.sh";
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
