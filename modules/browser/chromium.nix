{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.browser.chromium.enable;
  home = {
    packages = [config.sensible.browser.chromium.package];
  };
}
