{
  config,
  lib,
  ...
}: let
  networks =
    if config.sensible.wifi.networks != null
    then {networks = config.sensible.wifi.networks;}
    else builtins.warn "`networks` not set meaning that the declarative nature of wpa_supplicant won't work unless set elsewhere." {};
  secretsFile =
    if config.sensible.wifi.secretsFile != null
    then {
      secretsFile = config.sensible.wifi.secretsFile;
    }
    else builtins.warn "Having the secretsFile unset may mean that the passwords are in cleartext. This is strong discouraged and setting this will prevent having passwords visible, for all users, in the nix store." {};
in {
  condition = config.sensible.wifi.enable;
  system.networking = {
    networkmanager.enable = lib.mkForce false;
    wireless =
      {userControlled.enable = lib.mkDefault true;}
      // secretsFile // networks;
  };
}
