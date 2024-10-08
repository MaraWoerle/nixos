{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    plasma-manager.url = "github:nix-community/plasma-manager";
    agenix.url = "github:ryantm/agenix";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, spicetify-nix, agenix, ... }:
  {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [ 
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        spicetify-nix.nixosModules.default

        # Files
        ./config/laptop/configuration.nix
        ./home-manager/home-manager.nix
      ];
    };
  };
}
