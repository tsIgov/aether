{ ... }:
{
	programs.home-manager.enable = true;
	home = {
		username = "{{user}}";
		homeDirectory = "{{home}}";
		stateVersion = "23.11";
	};
}