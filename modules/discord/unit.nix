{
  config,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.discord.enable;
    system.sensible = {
      hyprland = {
        binds = [
          "$mod,D,exec,hyprkool toggle-special-workspace --name discord"
        ];
        windowrules = [
          "workspace special:discord silent, class:discord"
          "fullscreen, class:discord"
          "suppressevent movewindow movewindowv2, class:discord"
          "animation fade, class:discord"
        ];
      };
      niri = {
        binds = [
          ''Mod+D { spawn "sh" "-c" "niri msg action focus-workspace --name discord || niri msg action spawn -- discord"; }''
        ];
      };
    };
    home = {
      home.packages = [
        config.sensible.discord.package
      ];
      
    };
  })
  |> sensibleConfig
