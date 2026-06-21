{
  config,
  pkgs,
  sensibleLib,
  ...
}:
with sensibleLib;
  (makeGraphical config {
    condition = config.sensible.walker.enable;
    home = {
      packages = with pkgs; [
        walker
      ];
    };
  })
  |> sensibleConfig
