{
  config,
  sensibleLib,
  ...
}:
sensibleLib.sensibleConfig {
  condition = config.sensible.secrets.enable && config.sensible.secrets.nixSecretOptions != null;
  system = {
    nix.extraOptions = ''
      !include ${config.sensible.secrets.nixSecretOptions}
    '';
  };
}
