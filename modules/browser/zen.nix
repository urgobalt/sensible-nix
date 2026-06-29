{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.browser.zen.enable;
  home = {
    packages = [config.sensible.browser.zen.package];
  };
}
