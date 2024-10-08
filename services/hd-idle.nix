{ config, lib, pkgs, ... }:

let
  cfg = config.services.hd-idle;
in

with lib;

{
  options = {
    services.hd-idle = {
      enable = mkEnableOption "Enable the HD-Spindown";

      args = mkOption {
        default = "-i 5";
        type = with types; str;
        description = ''
          Arguments to pass to hd-idle
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.hd-idle = {
      description = "HD-Idle";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
          Type = "simple";
          Restart = "always";
          RestartSec = 1;
          ExecStart = "/run/current-system/sw/bin/hd-idle ${cfg.args}";
      };
    };
  };
}
