{lib, ...}: {
  options = with lib; {
    default = {
      username = mkOption {
        default = null;
        type = with types; nullOr str;
        description = "The default username of your administrator account on each system.";
      };
      modules = mkOption {
        default = [];
        type = with types; listOf anything;
        description = "Modules that will be added to all systems.";
      };
      specialArgs = mkOption {
        default = {};
        type = types.attrs;
        description = "Extra arguments passed to the modules of all systems.";
      };
      wallpaper = mkOption {
        default = null;
        type = with types; nullOr path;
        description = "This is the fallback wallpaper of all systems. See `systems.<name>.wallpaper` for more details.";
      };
    };
    systems = mkOption {
      type = with types;
        attrsOf (submodule {
            options = {
              system = mkOption {
                default = null;
                type = with types; nullOr str;
                description = "The system type.";
              };
              stateVersion = mkOption {
                type = types.str;
                description = "The stateVersion should be set to the version of nixos when the system was installed to prevent the system from breaking across nixos updates.";
              };
              username = mkOption {
                default = null;
                type = with types; nullOr str;
                description = "The username on the system.";
              };
              modules = mkOption {
                default = [];
                type = with types; listOf anything;
                description = "Modules that is added to the system.";
              };
              specialArgs = mkOption {
                default = {};
                type = types.attrs;
                description = "Extra arguments passed to the system's modules.";
              };
              wallpaper =
                mkOption {
                  default = null;
                  type = with types; nullOr path;
                  description = "The wallpaper that will be used to theme your system in various ways. This option is also passed to the modules of the system.

        Obs! This option does not have any effect unless you enable the various options utilizing the wallpaper.";
                };
              wsl = mkOption {
                default = false;
                type = types.bool;
                description = "Enable [modules](https://github.com/nix-community/nixos-wsl) to allow installation in a [wsl](https://github.com/microsoft/WSL) environment.";
              };
              disko = mkOption {
                default = false;
                type = types.bool;
                description = "Enable [disko](https://github.com/nix-community/disko) for managing partitions and disk layout.";
              };
            };
          });
      description = "The systems configured by hostname. Note: The hostname of your system is automatically set to the key of the attribute set.";
    };
  };
}
