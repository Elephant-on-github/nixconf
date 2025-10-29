{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, self, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };  # Pass inputs here
        modules = [
          ./hosts/default/configuration.nix
          home-manager.nixosModules.home-manager 
          {
          	home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.eagle = import ./hosts/default/home.nix;	
          }
        ];
      };
    };
  };
}
