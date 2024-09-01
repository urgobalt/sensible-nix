{
  lib,
  config,
  ...
}: let
  cfg = config.modules.xdg;
in {
  options.modules.xdg = {enable = lib.mkEnableOption "xdg";};

  config = lib.mkIf cfg.enable {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      download = "$HOME/downloads";
      music = "$HOME/music";
      pictures = "$HOME/pictures";
      videos = "$HOME/videos";
      documents = "$HOME/other";
      desktop = "$HOME/other";
      publicShare = "$HOME/other";
      templates = "$HOME/other";
    };
    systemd.user.sessionVariables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
