{ pkgs, ... }:

{
	security.polkit.enable = true;

	environment.systemPackages = with pkgs; [
		polkit_gnome
	];

	systemd.user.services.polkit-authentication-agent = {
		enable = true;
		description = "Polkit GNOME authentication agent";
		
		serviceConfig = {
			Type = "simple";
			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
		};

		wantedBy = [ "default.target" ];
	};
}