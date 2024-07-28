{ config, lib, pkgs, ... }:

let
  bot-cfg = config.services.epz-bot;
  test-cfg = config.services.epz-test-bot;
in

with lib;

{
  options = {
    services.epz-bot = {
      enable = mkEnableOption "Enable the epz-bot.";

      directory = mkOption {
        type = with types; uniq str;
        description = ''
          Directory of the bot.
        '';
      };
    };

    services.epz-test-bot = {
      enable = mkEnableOption "Enable the epz-test-bot.";

      directory = mkOption {
        default = "";
        type = with types; uniq str;
        description = ''
          Directory of the bot.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf (bot-cfg.enable || test-cfg.enable) {
      # NodeJS
      environment.systemPackages = [ pkgs.nodejs ];

      # Database
      services.mysql = {
          enable = true;
          package = pkgs.mysql;
          ensureUsers = [
            {
              name = "epz_bot";
              ensurePermissions = {
                "epz_dbs.*" = mkIf bot-cfg.enable "ALL PRIVILEGES";
                "epz_dbs_test.*" = mkIf test-cfg.enable "ALL PRIVILEGES";
              };
            }
          ];
      };
    })
    (mkIf bot-cfg.enable {
      # Bot
      systemd.services.epz-bot = {
        description = "EPZ-Discord-Bot";
        wantedBy = ["multi-user.target"];
        after = ["network-online.target"];
        unitConfig = {
          RequiresMountsFor = "${bot-cfg.directory}";
        };
        serviceConfig = {
            Type = "simple";
            Restart = "always";
            RestartSec = 1;
            ExecStart = "${pkgs.nodejs}/bin/node ${bot-cfg.directory}/build/index.js";
            User = "root";
        };
      };

      services.mysql = {
        initialDatabases = [ { name = "epz_dbs"; } ];
        ensureDatabases = [ "epz_dbs" ];
      };
    })
    (mkIf test-cfg.enable {
      # Test Bot
      systemd.services.epz-test-bot = {
        description = "EPZ-Discord-Test-Bot";
        wantedBy = ["multi-user.target"];
        after = ["network-online.target"];
        unitConfig = {
          RequiresMountsFor = "${test-cfg.directory}";
        };
        serviceConfig = {
            Type = "simple";
            Restart = "always";
            RestartSec = 1;
            ExecStart = "${pkgs.nodejs}/bin/node ${test-cfg.directory}/build/index.js";
            User = "root";
        };
      };

      services.mysql = {
        initialDatabases = [ { name = "epz_dbs_test"; } ];
        ensureDatabases = [ "epz_dbs_test" ];
      };
    })
  ];
}
