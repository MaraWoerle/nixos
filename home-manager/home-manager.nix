{ config, pkgs, home-manager, plasma-manager, ... }:

{
  imports = [
    ./spicetify.nix
  ];
  home-manager.backupFileExtension = "backup";
  home-manager.users.mara = { config, pkgs, ... }:

  {
    imports = [
      ./all.nix
    ];

    home = {
      username = "mara";
      homeDirectory = "/home/mara";
      stateVersion = "24.05"; # Please read the comment before changing.
      packages = with pkgs; [
      ];
      # file = {
      # };
      # sessionVariables = {
      # };

      enableNixpkgsReleaseCheck = false;
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    xsession.numlock.enable = true;

    nixpkgs.config.allowUnfree = true;
  };
}
