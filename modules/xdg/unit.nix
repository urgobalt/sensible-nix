{
  config,
  pkgs,
  sensibleLib,
  ...
}:
let
  browser = config.sensible.xdg.defaultBrowser;
in
  with sensibleLib;
    (makeGraphical config {
      condition = config.sensible.xdg.enable;
      home = {
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
            defaultApplications =
              if browser != null
              then {
                "x-scheme-handler/http" = [browser];
                "x-scheme-handler/https" = [browser];
              }
              else {};
          };
        };
        home.sessionVariables = {
          GTK_USE_PORTAL = "1";
        };
      };
    })
    |> sensibleConfig
