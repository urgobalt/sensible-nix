{pkgs, wallpaper}:
(pkgs.formats.toml {}).generate "regreet.toml" {
  background = {
    path = wallpaper;
    fit = "Cover";
  };
  GTK = {
    application_prefer_dark_theme = true;
    font_name = "SourceCodePro Nerd Font";
  };
  commands = {
    reboot = ["systemctl" "reboot"];
    shutdown = ["systemctl" "poweroff"];
  };
  appearance.greeting_msg = "I use NixOS btw.";
}
