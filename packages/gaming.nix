{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Gaming
    discord
    lutris
    prismlauncher
    protontricks
    spotify
    steam
    vesktop
    wine
    winetricks
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
}
