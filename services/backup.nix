{ config, lib, pkgs, modulesPath, ... }:

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

    disk-uuid = mkOption {
      type = with types; uniq str;
      description = ''
        UUID of the disk partition to use
      '';
    };

    paths = mkOption {
      type = with types; listOf str;
      description = ''
        list of Paths to backup
      '';
    };

    passphrase = mkOption {
      default = "";
      type = with types; uniq str;
      description = ''
        Passphrase to use for the repo
      '';
    };
  };

  config = mkIf cfg.enable {
    # Automount Harddrive
    fileSystems."${cfg.directory}" =
      { device = "/dev/disk/by-uuid/${cfg.disk-uuid}";
        fsType = "ext4";
      };

    # Backup Home Folder
    services.borgbackup.jobs.general = {
      paths = cfg.paths;
      encryption = {
        mode = "repokey";
        passphrase = cfg.passphrase;
      };
      repo = cfg.directory;
      compression = "auto,zstd";
      startAt = "weekly";
    };
  };
}
