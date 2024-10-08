{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.services.jellyfin.enable {
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
