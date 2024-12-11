{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#package-group-1.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, home-manager, ... } @inputs:
	let
		lib = nixpkgs.lib;
		pkgs = importPackages nixpkgs;

		importPackages = input: import input { system = "x86_64-linux"; config.allowUnfree = true; };
		importModules = path: lib.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);

		overlay-packages = final: prev: {
			custom = import /etc/aether/src/custom-packages/default.nix { inherit pkgs; };
			#package-group-1 = importPackages inputs.package-group-1;
		};

	in {
		homeConfigurations = {
			"aether" = home-manager.lib.homeManagerConfiguration {
				pkgs = pkgs;
				extraSpecialArgs = { };
				modules = [ 
					({ ... }: { nixpkgs.overlays = [ overlay-packages ]; }) ] ++ 
					(importModules /etc/aether/src/user/modules) ++ 
					(importModules ~/.config/aether/modules) ++ [
					~/.config/aether/config.nix
				];
			};
		};
	};
}
