{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.fuzzel;
in {
  options.modules.fuzzel = {enable = mkEnableOption "fuzzel";};
  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = "1a1a19ab";
          text = "d1d1d1ff";
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
