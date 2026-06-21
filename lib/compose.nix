{
  config,
  lib,
  nixpkgs-unstable,
  home-manager,
  stylix,
  wsl,
  disko,
  nix-index-database,
  ...
}: let
  fallback = primary: secondary:
    if primary == null
    then secondary
    else primary;
  units = lib.flatten (map (name: [(../. + "/modules/${name}/unit.nix") (../. + "/modules/${name}/options.nix")]) (import ../modules));
in {
  defaultModules =
    lib.flatten [
      home-manager.nixosModules.home-manager

      stylix.nixosModules.stylix
      nix-index-database.nixosModules.nix-index

      units
    ]
    ++ config.default.modules;

  defaultSpecialArgs =
    {
      sensible_option = options: {options.sensible = options;};
    }
    // config.default.specialArgs;

  systems =
    builtins.mapAttrs (hostname: system: let
      user = fallback system.username config.default.username;
      assertions_and_warnings = {
        assertions = [
          {
            assertion = system.username != null || config.default.username != null;
            message = "Default username must be set if username is not set on all systems.";
          }
          {
            assertion = system.disko == false || system.wsl == false;
            message = "Disko and WSL should never be enabled together. You do not have partitions in a WSL installation.";
          }
        ];
        warnings = [];
      };
    in {
      system = system.system;
      modules = lib.flatten [
          {
            nixpkgs = {
              overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit (system) system;
                    config = {
                      allowUnfree = true;
                      allowInsecure = true;
                    };
                  };
                })
                (import ../overlays)
              ];
              config = {
                allowUnfree = true;
                allowInsecure = true;
              };
            };
            system.stateVersion = system.stateVersion;
            home-manager.users.${user}.home.stateVersion = system.stateVersion;
          }
          (lib.optional system.wsl wsl.nixosModules.wsl)
          (lib.optional system.disko disko.nixosModules.disko)
          assertions_and_warnings
        ]
        ++ system.modules;
      specialArgs =
        rec {
          inherit hostname user;
          sensibleLib = import ./lib.nix {inherit lib user;};
        }
        // system.specialArgs;
    })
    config.systems;
}
