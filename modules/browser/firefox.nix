{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.browser.firefox.enable;
  home = {
    packages = [config.sensible.browser.firefox.package];
  };
}
