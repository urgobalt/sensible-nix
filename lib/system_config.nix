{
  self,
  lib,
  config,
  system,
  home-manager,
  stylix,
  nix-index-database,
  wsl,
  disko,
  nixos-unstable,
  ...
}: {
  options = with lib; let
    system = {
      system = mkOption {
        type = types.str;
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
  in {
    defaultUsername = mkOption {
      default = null;
      type = with types; nullOr str;
      description = "The default username of your administrator account on each system.";
    };
    defaultModules = mkOption {
      default = [];
      type = with types; listOf anything;
      description = "Modules that will be added to all systems.";
    };
    defaultSpecialArgs = mkOption {
      default = {};
      type = types.attrs;
      description = "Extra arguments passed to the modules of all systems.";
    };
    defaultWallpaper = mkOption {
      default = null;
      type = with types; nullOr path;
    };
    systems = mkOption {
      type = with types; attrsOf (submodule {options = system;});
      description = "The systems configured by hostname. Note: The hostname of your system is automatically set to the key of the attribute set.";
    };
    _systems = mkOption {
      type = with types; attrsOf (submodule {options = system;});
      internal = true;
      description = "The systems configured by hostname. Note: The hostname of your system is automatically set to the key of the attribute set.";
    };
  };
  config = let
    fallback = primary: secondary:
      if primary == null
      then secondary
      else primary;
    units = lib.flatten (map (name: ["${self.outPath}/modules/${name}/unit.nix" "${self.outPath}/modules/${name}/options.nix"]) (import ../modules));
  in {
    assertions = let
      systems = builtins.attrValues config.systems;
    in [
      {
        assertion = let
          all_systems_have_usernames = lib.lists.foldl (b: e: b && e.username != null) true systems;
        in
          all_systems_have_usernames || config.default_username != null;
        message = "Default username must be set if username is not set on all systems.";
      }
      {
        assertion = lib.lists.foldl (b: e: b && (e.disko == null || e.wsl == null)) true systems;
        message = "Disko and WSL should never be enabled together. You do not have partitions in a WSL installation.";
      }
    ];
    defaultModules = let
      meta-configuration = {
        nixpkgs = {
          overlays = [
            (final: prev: {
              unstable = import nixos-unstable {
                inherit system;
                config = {
                  allowUnfree = true;
                  allowInsecure = true;
                };
              };
            })
          ];
          config = {
            allowUnfree = true;
            allowInsecure = true;
          };
        };
        system.stateVersion = system.stateVersion;
      };
    in
      lib.flatten [
        meta-configuration
        ../configuration.nix
        home-manager.nixosModules.home-manager

        stylix.nixosModules.stylix
        # nix-index-database.nixosModules.nix-index

        units

        {inherit (config) assertions warnings;}
      ];

    defaultSpecialArgs = {
      user = fallback system.username config.defaultUsername;
      wallpaper = fallback system.wallpaper config.defaultWallpaper;
      sensible_option = options: {options.sensible = options;};
    };

    _systems =
      lib.mapAttrs (hostname: value: let
        system = config.systems.${hostname};
      in {
        modules =
          lib.flatten [
            (lib.optional system.wsl wsl.nixosModules.wsl)
            (lib.optional system.disko disko.nixosModules.disko)
          ]
          ++ system.modules;
        specialArgs =
          {
            inherit hostname;
            sensible_config = config: let
              user = fallback system.username config.defaultUsername;
            in
              {
                assertions =
                  if builtins.hasAttr "assertions" config
                  then config.assertions
                  else [];
                home-manager.users.${user} =
                  if builtins.hasAttr "home" config
                  then config.home
                  else {};
              }
              // (
                if builtins.hasAttr "system" config
                then config.system
                else {}
              );
          }
          // system.specialArgs;
      })
      config.systems;
  };
}
