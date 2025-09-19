{
  config,
  sensible_config,
  ...
}:
sensible_config {
  condition = config.sensible.secrets.nixSecretOptions != null;
  system = {
    nix.extraOptions = ''
      !include ${config.sensible.secrets.nixSecretOptions}
    '';
  };
}
