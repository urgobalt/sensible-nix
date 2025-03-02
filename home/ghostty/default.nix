{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.ghostty;
  color = colors.nac;
in {
  options.modules.ghostty = {enable = mkEnableOption "ghostty";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghostty
    ];

    xdg.configFile."ghostty/config".text = import ./config.nix {inherit color;};
  };
}
