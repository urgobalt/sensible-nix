{
  config,
  pkgs,
  sensibleLib,
  lib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.gtk.enable;
    home = lib.mkForce {
      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
      gtk = {
        enable = true;
        font = {
          name = "SourceCodePro Nerd Font";
          size = 12;
          package = pkgs.source-code-pro;
        };
      };
    };
  })
  |> sensibleConfig
