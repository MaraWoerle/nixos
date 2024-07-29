{ pkgs, ... }:

{
  imports = [
    ./nano.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Editors and IDEs
    emacs
    jetbrains.clion
    nano
    vscode
  ];
}
