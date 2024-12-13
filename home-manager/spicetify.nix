{ config, pkgs, inputs, lib, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in

{
  config = lib.mkIf (config.plasma.enable || config.programs.hyprland.enable || config.i3.enable || config.sway.enable) {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "spotify"
    ];

    programs.spicetify =
    {
      enable = true;
      enabledCustomApps = with spicePkgs.apps; [
        marketplace
        betterLibrary
        lyricsPlus
      ];
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        beautifulLyrics
        hidePodcasts
        history
        betterGenres
        volumePercentage
        songStats
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "rose-pine-moon";
    };
  };
}
