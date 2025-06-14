{lib, ...}:
with lib; {
  secrets = {
    nix-secret-options = mkOption {
      type = with types; nullOr path;
      default = null;
      description = "Secret file that will be imported at the end of nix.conf.";
    };
    password-file = mkOption {
      type = with types; nullOr path;
      default = null;
      description = "Secret file that holds the hashed user password. OBS: This option will make the users immutable.";
    };
  };
  wifi = {
    enable = mkOption {
      type = types.boolean;
      default = false;
      description = "Enable a declarative wifi management solution through wpa_supplicant.";
    };
    secretsFile = mkOption {
      type = with types; nullOr path;
      default = null;
      description = ''
        File consisting of lines of the form `varname=value` to define variables for the wireless configuration.

        Secrets (PSKs, passwords, etc.) can be provided without adding them to the world-readable Nix store by defining them in the secrets file. Example:
        ```env
        # content of file
        psk_home=mypassword
        psk_other=6a381cea59c7a2d6b30736ba0e6f397f7564a044bcdb7a327a1d16a1ed91b327
        pass_work=myworkpassword
        ```
      '';
    };
    networks = mkOption {
      type = with types; nullOr attrs;
      default = null;
      description = "Network definition to automatically connect when `wpa_supplicant` is running.";
      example = ''
          { echelon = {                   # SSID with no spaces or special characters
            psk = "abcdefgh";           # (password will be written to /nix/store!)
          };

          echelon = {                   # safe version of the above: read PSK from the
            pskRaw = "ext:psk_echelon"; # variable psk_echelon, defined in secretsFile,
          };                            # this won't leak into /nix/store

          "echelon's AP" = {            # SSID with spaces and/or special characters
             psk = "ijklmnop";          # (password will be written to /nix/store!)
          };

          "free.wifi" = {};             # Public wireless network
        };
      '';
    };
  };
}
