{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    plasma-manager.url = "github:nix-community/plasma-manager";
    agenix.url = "github:ryantm/agenix";
    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
    # raspberry-pi-nix.url = "github:nix-community/raspberry-pi-nix";
  };
  outputs = inputs@{ self, nixpkgs, plasma-manager, home-manager, spicetify-nix, agenix, lix-module, ... }:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [ 
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          spicetify-nix.nixosModules.default
          lix-module.nixosModules.default
          {
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          }

          # Files
          ./config/desktop/configuration.nix
          ./home-manager/home-manager.nix
        ];
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [ 
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          spicetify-nix.nixosModules.default
          lix-module.nixosModules.default
          {
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          }

          # Files
          ./config/laptop/configuration.nix
          ./home-manager/home-manager.nix
        ];
      };
      nipogi-server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [ 
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          spicetify-nix.nixosModules.default
          lix-module.nixosModules.default
          {
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          }

          # Files
          ./config/nipogi-server/configuration.nix
          ./home-manager/home-manager.nix
        ];
      };
      nixos-raspi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {inherit inputs;};
        modules = [ 
          agenix.nixosModules.default
          home-manager.nixosModules.home-manager
          spicetify-nix.nixosModules.default
          lix-module.nixosModules.default
          # raspberry-pi-nix.nixosModules.raspberry-pi
          {
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
          }

          # Files
          ./config/raspi/configuration.nix
          ./home-manager/home-manager.nix
        ];
      };
    };
  };
}
