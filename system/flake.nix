{
	description = "Aether desktop environment";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs, ... } @inputs:
	let
		lib = nixpkgs.lib;
		pkgs = importPackages nixpkgs;

		importPackages = input: import input { system = "x86_64-linux"; config.allowUnfree = true; };
		importModules = path: lib.filter (n: lib.strings.hasSuffix ".nix" (toString n)) (lib.filesystem.listFilesRecursive path);

	in {
		nixosConfigurations = {
			"aether" = nixpkgs.lib.nixosSystem {
				specialArgs = { };
				modules = (importModules /etc/aether/system-config) ++ (importModules /etc/aether/src/system/modules);
			};
		};
	};
}