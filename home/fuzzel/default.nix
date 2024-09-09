{
  pkgs,
  lib,
  config,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.fuzzel;
  c = colors.no_prefix;
in {
  options.modules.fuzzel = {enable = mkEnableOption "fuzzel";};
  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = c.background;
          text = c.text;
          match = "7bb099ff";
          selection = "2a2a29ff";
          selection-text = "d1d1d1ff";
          selection-match = "7bb099ff";
          border = "ffdeaaff";
        };
        border = {
          width = 4;
        };
      };
    };
  };
}
