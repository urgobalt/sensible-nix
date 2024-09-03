{
  config.modules = {
    declarative-password.enable = false; # Set this to true ONLY when you have properly configured your ssh keys
    wifi = {
      enable = false; # You need to learn about wpa_supplicant environment files to enable this
      networks = {
        # { echelon = {                   # SSID with no spaces or special characters
        #     psk = "abcdefgh";           # (password will be written to /nix/store!)
        #   };
        #
        #   echelon = {                   # safe version of the above: read PSK from the
        #     psk = "@PSK_ECHELON@";      # variable PSK_ECHELON, defined in environmentFile,
        #   };                            # this won't leak into /nix/store
        #
        #   "echelon's AP" = {            # SSID with spaces and/or special characters
        #      psk = "ijklmnop";          # (password will be written to /nix/store!)
        #   };
        #
        #   "free.wifi" = {};             # Public wireless network
        # }
      };
    };
    hyprland.enable = true;
    display-manager.enable = true;
    steam.enable = true;
  };
}
