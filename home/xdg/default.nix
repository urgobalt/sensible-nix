{
  lib,
  config,
  ...
}: let
  modules = config.modules;
  cfg = modules.xdg;
  browsers =
    ["firefox.desktop"]
    ++ lib.optional modules.zen.enable "zen.desktop"
    ++ lib.optional modules.chromium.enable "chromium.desktop";
  defaultBrowser =
    ["firefox.desktop"]
    ++ lib.optional (cfg.defaultBrowser != null) cfg.defaultBrowser;
in {
  options.modules.xdg = with lib; {
    enable = mkEnableOption "xdg";
    defaultBrowser = mkOption {
      type = with types; nullOr (enum (browsers ++ cfg.extraBrowsers));
      default = null;
      description = "The default browser that should be added to mime.";
    };
    extraBrowsers = mkOption {
      type = with types; listOf str;
      default = [];
      description = "Extra browser desktop files that need to be defined.";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      userDirs = {
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
      mime.enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "x-scheme-handler/http" = defaultBrowser;
          "x-scheme-handler/https" = defaultBrowser;
        };
      };
    };
    home.sessionVariables = {
      GTK_USE_PORTAL = "1";
    };
  };
}
