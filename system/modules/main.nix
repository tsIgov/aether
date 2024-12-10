{ pkgs, ... }:

{ 
	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	environment.systemPackages = with pkgs; [
		home-manager
		jq
		(writeShellScriptBin "aether-system" (builtins.readFile /etc/aether/src/scripts/aether-system.sh))
		(writeShellScriptBin "aether" (builtins.readFile /etc/aether/src/scripts/aether.sh))
	];
}