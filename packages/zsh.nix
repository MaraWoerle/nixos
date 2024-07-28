{ config, lib, pkgs, modulesPath, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.mara.shell = pkgs.zsh;

  programs.zsh = {
    enable = true;
    enableLsColors = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch";
      cleanup = "sudo nix-collect-garbage -d";
    };

    ohMyZsh = {
      enable = true;
      theme = "rkj-repos";
    };

    promptInit = ''eval "$(zoxide init zsh)"'';
  };
  environment.systemPackages = with pkgs; [
    fzf
    zoxide
    thefuck
  ];

  console.colors = [
    # Dark
    "182030" # Black
    "b93368" # Red
    "008080" # Green
    "b93368" # "Yellow"
    "009abd" # Blue
    "5c4a94" # Magenta
    "009abd" # Cyan
    "c5ccd4" # White

    # Bright
    "5c4a94" # Black
    "dd3d7d" # Red
    "009c9c" # Green
    "967af4" # "Yellow"
    "00aad4" # Blue
    "856cd9" # Magenta
    "00b4dd" # Cyan
    "d3dae3" # White
  ];

  # Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [
      "Inconsolata"
      "InconsolataGo"
      "Hack"
      "Noto"
    ]; })
  ];
}
