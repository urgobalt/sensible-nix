{
  pkgs,
  lib,
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.browser.zen.enable;
  home = {
    packages = [config.sensible.browser.zen.package];
  };
}
