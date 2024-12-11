{ ... }:
{ 
	users.mutableUsers = true;
	users.users."{{user}}" = {
		description = "{{username}}";
		extraGroups = [ "wheel" "networkmanager"];
		isNormalUser = true;
		createHome = true;
		useDefaultShell = true;
	};
}
