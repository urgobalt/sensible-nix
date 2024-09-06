{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.rofi;
in {
  options.modules.rofi = {
    enable = mkOption {
      name = "rofi";
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
          background:     ${colors.hex.background};
          background-alt: ${colors.hex.black};
          foreground:     ${colors.hex.text};
          selected:       ${colors.hex.cyan};
          active:         ${colors.hex.yellow};
          urgent:         ${colors.hex.red};
          font:           "SourceCodePro Nerd Font 14";
      }
    '';
  };
}
