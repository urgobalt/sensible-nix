{config, ...}: {
  condition = config.sensible.secrets.nix-secret-options != null;
  system = {
    nix.extraOptions = ''
      !include ${config.sensible.secrets.nix-secret-options}
    '';
  };
}
