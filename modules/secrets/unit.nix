{
  config,
  lib,
  ...
}: {
  imports = [
    ./declarative-password.nix
    ./mutable-password.nix
    ./nix-secret-config.nix
  ];

  assertions = [
    {
      assertion = !config.sensible.secrets.enable || (config.sensible.secrets.passwordFile != null || config.sensible.secrets.password != null);
      message = "sensible.secrets.enable requires either passwordFile or password to be set";
    }
  ];
}
