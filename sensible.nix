{
  nixpkgs,
  nixpkgs-unstable,
  wsl,
  disko,
  home-manager,
  stylix,
  nix-index-database,
  self,
  ...
}: userConfig: let
  systems = userConfig.systems;
  systemNames = builtins.attrNames systems;
  config = systemConfig
  : let
    getAttr = name: set: msg:
      if builtins.hasAttr name set
      then set.${name}
      else builtins.throw msg;
    system = systemConfig.system;

    # Application predicate that is allowed to be marked insecure
    insecure =
      [
        "electron"
      ]
      ++ systemConfig.insecurePredicate;
    opt = flag: module: nixpkgs.lib.optionals (builtins.hasAttr flag systemConfig && systemConfig.${flag}) module;
  in
    nixpkgs.lib.nixosSystem {
      system = system;

      modules = nixpkgs.lib.flatten [
        ./configuration.nix
        (
          input @ {pkgs, ...}: {
            imports = import ./modules {
              importUnits = (import ./lib/importUnits.nix) input;
              root = self.outPath;
              lib = nixpkgs.lib;
            };
          }
        )

        stylix.nixosModules.stylix
        nix-index-database.nixosModules.nix-index

        home-manager.nixosModules.home-manager

        (opt "wsl" wsl.nixosModules.wsl)
        (opt "disko" disko.nixosModules.disko)

        rec {
          system.stateVersion =
            if builtins.hasAttr "stateVersion" systemConfig
            then systemConfig.stateVersion
            else builtins.throw "All system should have a stateVersion. The reason is connected to system compatability and making sure that things stay working when upgrading. Bumping stateVersion MAY be irreversable if the system has become incompatible.";
          home-manager.users.${userConfig.user}.home.stateVersion = system.stateVersion;
        }

        {
          environment.systemPackages =
            if builtins.hasAttr "packages" systemConfig
            then systemConfig.packages
            else [];
        }
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = system;
                config.allowUnfree = true;
              };
            })
            (import ./overlays)
          ];
          nixpkgs.config = {
            allowUnfree = true;
            allowInsecurePredicate = pkg:
              builtins.elem (nixpkgs.lib.getName pkg) insecure;
          };
        }

        # TODO: create some sort of generator attribute for the host files

        (nixpkgs.lib.optionals (builtins.hasAttr "modules" systemConfig) systemConfig.modules)
        (nixpkgs.lib.optionals (builtins.hasAttr "defaultModules" userConfig) userConfig.defaultModules)
      ];

      specialArgs =
        {
          user = userConfig.user;
          wallpaper =
            if builtins.hasAttr "wallpaper" systemConfig
            then systemConfig.wallpaper
            else if builtins.hasAttr "defaultWallpaper" userConfig
            then userConfig.defaultWallpaper
            else null;
          ssh = getAttr "ssh" userConfig "SSH is required to be setup. Find instructions here: https://example.com";
          root = self.outPath;
          hostname = systemConfig.hostname;
        }
        // (nixpkgs.lib.attrsets.optionalAttrs (builtins.hasAttr "specialArgs" systemConfig) systemConfig.specialArgs)
        // (nixpkgs.lib.attrsets.optionalAttrs (builtins.hasAttr "defaultSpecialArgs" userConfig) userConfig.defaultSpecialArgs);
    };
in {
  nixosConfigurations = nixpkgs.lib.genAttrs systemNames (name: (config (systems.${name} // {hostname = name;})));
}
