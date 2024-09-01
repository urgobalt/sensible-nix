{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gtk;
in {
  options.modules.gtk = {enable = mkEnableOption "gtk";};
  config = mkIf cfg.enable {
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
        package = pkgs.nerdfonts.override {fonts = ["SourceCodePro"];};
      };
    };
  };
}
