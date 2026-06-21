{
  config,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.fuzzel.enable;
    home.programs.fuzzel = {
      enable = true;
      settings = {
        border = {
          width = 4;
        };
      };
    };
  })
  |> sensibleConfig
