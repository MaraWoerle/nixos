{ config, pkgs, lib, ... }:

with lib;

{
  config = mkIf config.programs.zsh.enable {
    users.defaultUserShell = pkgs.zsh;

    programs.zsh = {
      enableLsColors = true;
      enableCompletion = true;
      autosuggestions = {
        enable = true;
        highlightStyle = "fg=13";
      };
      syntaxHighlighting.enable = true;

      shellAliases = {
        update = "sudo nixos-rebuild switch";
        cleanup = "sudo nix-collect-garbage -d";
        cleanbuild = "update && cleanup";
      };

      ohMyZsh = {
        enable = true;
        theme = "rkj-repos";
      };
      
      promptInit = ''eval "$(zoxide init zsh; atuin init zsh; thefuck --alias)"'';
    };
    environment.systemPackages = with pkgs; [
      fzf
      zoxide
      thefuck
      atuin
    ];

    console.colors = [
      "182030" #30-Black
      "b93368" #31-Red
      "008080" #32-Green
      "b93368" #33-Yellow
      "006bbd" #34-Blue
      "5c4a94" #35-Purple
      "009abd" #36-Cyan
      "c5ccd4" #37-Grey

      "212d43" #40-Light-Black
      "dd3d7d" #41-Light-Red
      "009c9c" #42-Light-Green
      "dd3d7d" #43-Light-Yellow
      "0087e1" #44-Light-Blue
      "856cd9" #45-Light-Purple
      "00b4dd" #46-Light-Cyan
      "edf5ff" #47-Light-Grey
    ];

    # Nerd Fonts
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [
        "Hack"
      ]; })
    ];
  };
}
