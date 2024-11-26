{ config, lib, ... }:

let
  cfg = config.local-backup;
in

with lib;

{
  options.local-backup = {
    enable = mkEnableOption "Enable the Backup";

    directory = mkOption {
      type = with types; uniq str;
      description = ''
        Directory of the Backup
      '';
    };

    paths = mkOption {
      type = with types; listOf str;
      description = ''
        list of Paths to backup
      '';
    };

    repokey = mkOption {
      type = with types; uniq str;
      default = "";
      description = ''
        Repokey of the Backup
      '';
    };
  };

  config = mkIf cfg.enable {
    # Backup Home Folder
    services.borgbackup.jobs.general = {
      persistentTimer = true;
      removableDevice = true;
      paths = cfg.paths;
      encryption = {
        mode = "repokey";
        passphrase = cfg.repokey;
      };
      repo = "${cfg.directory}";
      compression = "auto,zstd";
      startAt = "weekly";
      prune.keep = {
        within = "1m";
        monthly = -1;
      };
    };
  };
}
