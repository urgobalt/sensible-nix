{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.rofi;
  c = colors.regular;
in {
  options.modules.rofi = {
    enable = mkOption {
      type = types.bool;
      default = config.modules.hyprland.enable;
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      rofi-wayland
      cliphist
    ];

    xdg.configFile."rofi/config.rasi".source = ./theme.rasi;
    xdg.configFile."rofi/assets.rasi".text = ''
      * {
          background:     ${c.background};
          background-alt: ${c.black};
          foreground:     ${c.text};
          selected:       ${c.cyan};
          active:         ${c.yellow};
          urgent:         ${c.red};
          font:           "SourceCodePro Nerd Font 14";
      }
    '';
  };
}
