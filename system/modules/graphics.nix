{ config, lib, ... }:

let
  cfg = config.hardware.graphics;
in
{
	options = with lib; with types;{
		hardware.graphics.nvidia = mkOption { type = lib.types.bool; description = "Enables Nvidia specific settings"; };
	};

	config = lib.mkIf (cfg.nvidia == true) {
		hardware.nvidia = {
			modesetting.enable = true;
			powerManagement.enable = false;
			powerManagement.finegrained = false;
			open = false;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.stable;
		};

		services.xserver.videoDrivers = ["nvidia"];

		environment.sessionVariables = {
				#WLR_NO_HARDWARE_CURSORS = "1";
		};
	};
}