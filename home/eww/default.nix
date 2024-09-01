{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.eww;
in {
  options.modules.eww = {enable = mkEnableOption "eww";};
  config = mkIf cfg.enable {
    # theres no programs.eww.enable here because eww looks for files in .config
    # thats why we have all the home.files

    # eww package
    home.packages = with pkgs; [
      eww
      jq
      socat
      (nerdfonts.override {fonts = ["SourceCodePro"];})
    ];

    xdg.configFile."eww" = {
      source = ./bar;
      recursive = true;
    };
  };
}
