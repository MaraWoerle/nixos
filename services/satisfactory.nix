{ config, lib, pkgs, ... }:

let
  cfg = config.services.satisfactory;
in

with lib;

{
  options.services.satisfactory = {
    enable = mkEnableOption "Enable Satisfactory Dedicated Server";

    beta = mkOption {
      type = types.enum [ "public" "experimental" ];
      default = "public";
      description = "Beta channel to follow";
    };

    address = mkOption {
      type = types.str;
      default = "0.0.0.0";
      description = "Bind address";
    };

    maxPlayers = mkOption {
      type = types.number;
      default = 4;
      description = "Number of players";
    };

    autoPause = mkOption {
      type = types.bool;
      default = true;
      description = "Auto pause when no players are online";
    };

    autoSaveOnDisconnect = mkOption {
      type = types.bool;
      default = true;
      description = "Auto save on player disconnect";
    };

    extraSteamCmdArgs = mkOption {
      type = types.str;
      default = "";
      description = "Extra arguments passed to steamcmd command";
    };
  };
  config = mkIf cfg.enable {
    users.users.satisfactory = {
      home = "/var/lib/satisfactory";
      createHome = true;
      isSystemUser = true;
      group = "satisfactory";
    };
    users.groups.satisfactory = {};

    nixpkgs.config.allowUnfree = true;

    networking = {
      firewall = {
        enable = false;
        allowedUDPPorts = [ 15777 15000 7777 27015 ];
        allowedUDPPortRanges = [ { from = 27031; to = 27036; } ];
        allowedTCPPorts = [ 27015 27036 ];
      };
    };

    systemd.services.satisfactory = {
      wantedBy = [ "multi-user.target" ];
      after = ["network-online.target"];
      wants = [ "network-online.target" ];
      preStart = ''
        ${pkgs.steamcmd}/bin/steamcmd \
          +force_install_dir /var/lib/satisfactory/SatisfactoryDedicatedServer \
          +login anonymous \
          +app_update 1690800 \
          -beta ${cfg.beta} \
          ${cfg.extraSteamCmdArgs} \
          validate \
          +quit
        ${pkgs.patchelf}/bin/patchelf --set-interpreter ${pkgs.glibc}/lib/ld-linux-x86-64.so.2 /var/lib/satisfactory/SatisfactoryDedicatedServer/Engine/Binaries/Linux/FactoryServer-Linux-Shipping
        ln -sfv /var/lib/satisfactory/.steam/steam/linux64 /var/lib/satisfactory/.steam/sdk64
        mkdir -p /var/lib/satisfactory/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer
        ${pkgs.crudini}/bin/crudini --set /var/lib/satisfactory/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/Game.ini '/Script/Engine.GameSession' MaxPlayers ${toString cfg.maxPlayers}
        ${pkgs.crudini}/bin/crudini --set /var/lib/satisfactory/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoPause ${if cfg.autoPause then "True" else "False"}
        ${pkgs.crudini}/bin/crudini --set /var/lib/satisfactory/SatisfactoryDedicatedServer/FactoryGame/Saved/Config/LinuxServer/ServerSettings.ini '/Script/FactoryGame.FGServerSubsystem' mAutoSaveOnDisconnect ${if cfg.autoSaveOnDisconnect then "True" else "False"}
      '';
      serviceConfig = {
        Restart = "always";
        User = "satisfactory";
        Group = "satisfactory";
        ExecStart = "/run/current-system/sw/bin/sh /var/lib/satisfactory/SatisfactoryDedicatedServer/FactoryServer.sh";
        WorkingDirectory = "/var/lib/satisfactory";
      };
      environment = {
        LD_LIBRARY_PATH="SatisfactoryDedicatedServer/linux64:SatisfactoryDedicatedServer/Engine/Binaries/Linux:SatisfactoryDedicatedServer/Engine/Binaries/ThirdParty/PhysX3/Linux/x86_64-unknown-linux-gnu";
      };
    };
  };
}
