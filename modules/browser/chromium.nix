{
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.browser.chromium.enable;
  home = {
    packages = [config.sensible.browser.chromium.package];
  };
}
