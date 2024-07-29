{ ... }:

{
  imports = [
    ./packages/cli-utils.nix
    ./services/all.nix
    ./german-locale.nix
    ./nix.nix
  ];
}
