{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf services.jellyfin.enable {
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
