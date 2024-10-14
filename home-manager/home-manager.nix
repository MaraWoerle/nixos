{ config, pkgs, home-manager, plasma-manager, ... }:

{
  imports = [
    ./spicetify.nix
  ];
  home-manager.users.mara = { config, pkgs, ... }:

  {
    imports = [
      ./plasma.nix
    ];
    
    home = {
      username = "mara";
      homeDirectory = "/home/mara";
      stateVersion = "24.05"; # Please read the comment before changing.
      packages = with pkgs; [
        (catppuccin-kvantum.override {
          accent = "Blue";
          variant = "Macchiato";
        })
      ];
      # file = {
      # };
      sessionVariables = {
        # QT_QPA_PLATFORMTHEME = "qt5ct";
      };
    };

    qt = {
      enable = true;
      platformTheme = "qtct";
      style.name = "kvantum";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    xsession.numlock.enable = true;

    nixpkgs.config.allowUnfree = true;
  };
}
