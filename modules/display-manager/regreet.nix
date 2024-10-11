{
  pkgs,
  wallpaper,
}:
(pkgs.formats.toml {}).generate "regreet.toml" {
  background = {
    path = wallpaper;
    fit = "Cover";
  };
  commands = {
    reboot = ["systemctl" "reboot"];
    shutdown = ["systemctl" "poweroff"];
  };
  appearance.greeting_msg = "I use NixOS btw.";
  GTK = {
    application_prefer_dark_theme = true;
  };
}
