{ config, pkgs, home-manager, ... }:

{
  imports = [
    # ./plasma.nix
    ./spicetify.nix
  ];

  home-manager.users.mara = { config, pkgs, ... }:

  {
    home = {
      username = "mara";
      homeDirectory = "/home/mara";
      stateVersion = "24.05"; # Please read the comment before changing.
      # packages = with pkgs; [
      # ];
      # file = {
      # };
      # sessionVariables = {
      # };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    xsession.numlock.enable = true;

    nixpkgs.config.allowUnfree = true;
  };
}
