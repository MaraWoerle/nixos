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

      db-enable = mkEnableOption "Enable the Database";
      db-backup-enable = mkEnableOption "Enable the Backup";
      db-backup-path = mkOption {
        type = with types; uniq str;
        description = ''
          Directory of the backup.
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

      db-enable = mkEnableOption "Enable the Database";
      db-backup-enable = mkEnableOption "Enable the Backup";
    };
  };

  config = mkMerge [
    (mkIf (bot-cfg.enable || test-cfg.enable) {
      # NodeJS
      environment.systemPackages = [ pkgs.nodejs ];
    })
    (mkIf (bot-cfg.db-enable || test-cfg.db-enable) {
      # Database
      services.mysql = {
        enable = true;
        package = pkgs.mysql;
        ensureUsers = [
          {
            name = "epz_bot";
            ensurePermissions = {
              "epz_dbs.*" = "ALL PRIVILEGES";
              "epz_dbs_test.*" = "ALL PRIVILEGES";
            };
          }
        ];
      };
      services.mysqlBackup = {
        user = "root";
        enable = bot-cfg.db-backup-enable || test-cfg.db-backup-enable;
        location = bot-cfg.db-backup-path;
        calendar = "7 01:15:00";
      };
      networking.firewall = {
        allowedTCPPorts = [ 3306 ];
        allowedUDPPorts = [ 3306 ];
      };
    })
    (mkIf bot-cfg.db-backup-enable {
      services.mysqlBackup.databases = [
        "epz_dbs"
      ];
    })
    (mkIf test-cfg.db-backup-enable {
      services.mysqlBackup.databases = [
        "epz_dbs_test"
      ];
    })
    (mkIf bot-cfg.enable {
      # Bot
      systemd.services.epz-bot = {
        description = "EPZ-Discord-Bot";
        wantedBy = ["multi-user.target"];
        wants = [ "network-online.target" ];
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
    })
    (mkIf test-cfg.enable {
      # Test-Bot
      systemd.services.epz-test-bot = {
        description = "EPZ-Discord-Test-Bot";
        wantedBy = ["multi-user.target"];
        wants = [ "network-online.target" ];
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
    })
  ];
}
