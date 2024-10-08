{ ... }:

{
  imports = [
    # ./home-manager/home-manager.nix
    ./packages/all.nix
    ./services/all.nix
    ./standard/german-locale.nix
    ./standard/nix.nix
    ./secrets/all.nix
  ];
}
