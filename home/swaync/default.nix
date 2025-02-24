{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.swaync;
  c = colors.rgba;
in {
  options.modules.swaync = {enable = mkEnableOption "swaync";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [swaynotificationcenter];

    xdg.configFile."swaync/config.json".text = import ./config.nix;
    xdg.configFile."swaync/style.css".text = import ./style.nix {color = c;};
  };
}
