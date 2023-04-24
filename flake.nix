{
  description = "Home Manager configuration of vini";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixOsConfigurations = nixpkgs.lib.nixosSystem {
        "42sp" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modues = [
            ./nixos/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        "vini@42sp" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [ ./home.nix ];
        };
      };
    };
}
