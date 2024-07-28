{ config, lib, pkgs, ... }:

with lib;

{
  config = mkIf config.services.jellyfin.enable {
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
