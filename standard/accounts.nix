{ config, pkgs, ... }:

{
  users = {
      groups = {
        tmux = {};
      };

    users = {
      mara = {
        isNormalUser = true;
        description = "Mara";
        shell = pkgs.zsh;
        home = "/home/mara";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "hamachi"
          "adbusers"
          "tmux"
        ];
      };

      loris = {
        isNormalUser = true;
        description = "Loris";
        shell = pkgs.zsh;
        extraGroups = [
          "wheel"
          "tmux"
        ];
      };
    };
  };
}
