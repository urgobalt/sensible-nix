{
  pkgs,
  lib,
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.browser.firefox.enable;
  home = {
    packages = [config.sensible.browser.firefox.package];
  };
}
