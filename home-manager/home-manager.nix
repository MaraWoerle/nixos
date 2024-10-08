{ config, pkgs, ... }:

{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.mara = { config, pkgs, ... }:

  {
    inputs.spicetify-nix.url = "github:the-argus/spicetify-nix";
    imports = [
      ./plasma.nix
    ];

    home = {
      username = "mara";
      homeDirectory = "/home/mara";
      stateVersion = "24.05"; # Please read the comment before changing.
      packages = with pkgs; [
      ];
      file = {
      };
      sessionVariables = {
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    xsession.numlock.enable = true;

    nixpkgs.config.allowUnfree = true;
  };
}
