{ config, pkgs, lib, ... }:

let
  cfg = config.programs.gaming;
in

with lib;

{
  options.programs.gaming.enable = mkEnableOption "Enable Gaming software";

  config = mkIf cfg.enable {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      # Gaming
      (pkgs.discord.override {
        withOpenASAR = true;
      })
      lutris
      nexusmods-app
      prismlauncher
      protontricks
      # spotify
      # spicetify-cli
      steam
      r2modman
      vesktop
      wine
      winetricks
      xwaylandvideobridge
    ];

    # Steam
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };

    # Hamachi
    services.logmein-hamachi.enable = true;

    # OpenRGB
    services.hardware.openrgb.enable = true;
  };
}
