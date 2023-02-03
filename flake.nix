{
  description = "minix to rule them all";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Tricked out nvim (I am NOT using vim in the foreseeable future...)
    # pwnvim.url = "github:zmre/pwnvim";
  };
  # Don't forget to add pwnvim again, if that ever happens....
  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
    darwinConfigurations.high-sierra = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      pkgs = import nixpkgs { system = "x86_64-darwin"; };
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            # extraSpecialArgs = { inherit pwnvim; };
 	    extraSpecialArgs = { };
            users.seff.imports = [ ./modules/home-manager/default.nix ];
          };
        }
      ];
    };
      homeConfigurations.seff = let system = "x86_64-linux"; in home-manager.lib.homeManagerConfiguration {
    	  pkgs = nixpkgs.legacyPackages.${system};
          modules = [
         ./modules/home-manager/linux.nix
	     ./modules/home-manager/default.nix
	     {
	       home = {
	     	  username = "seff";
	     	  homeDirectory = "/home/seff";
	       };
	     }
          ];
      };
    };
}
