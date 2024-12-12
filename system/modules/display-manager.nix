{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];

  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --user-menu --time --time-format '%Y-%m-%d %H:%M:%S' --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}