{ pkgs, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables.NIXOS_OZONE_WL = "1";

	xdg.portal = { 
		enable = true; 
		extraPortals = [ 
			pkgs.xdg-desktop-portal-hyprland 
			pkgs.xdg-desktop-portal-gtk 
		]; 
	}; 

	hardware.graphics.enable = true;

	security.pam.services.swaylock = {};
	environment.systemPackages = with pkgs; [
      swaylock-effects
  ];
}
