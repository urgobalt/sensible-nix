{
  nixpkgs,
  nixpkgs-unstable,
  wsl,
  disko,
  home-manager,
  stylix,
  agenix,
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
          input @ {pkgs, ...}:
            nixpkgs.lib.foldl nixpkgs.lib.recursiveUpdate {} (import ./modules {
              inherit input;
              importUnit = (import ./lib/importUnit.nix) input;
              root = self.outPath;
              lib = nixpkgs.lib;
            })
        )

        agenix.nixosModules.default
        nix-index-database.nixosModules.nix-index
        home-manager.nixosModules.home-manager

        (opt "wsl" wsl.nixosModules.wsl)
        (opt "disko" disko.nixosModules.disko)

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
        (nixpkgs.lib.optionals (builtins.hasAttr "modules" systemConfig) systemConfig.modules)
      ];

      specialArgs = {
        inherit agenix;
        user = userConfig.user;
        wallpaper =
          if builtins.hasAttr "wallpaper" systemConfig
          then systemConfig.wallpaper
          else if builtins.hasAttr "defaultWallpaper" userConfig
          then userConfig.defaultWallpaper
          else "";
        ssh = getAttr "ssh" userConfig "SSH is required to be setup. Find instructions here: https://example.com";
        root = self.outPath;
        hostname = systemConfig.hostname;
      };
    };
in {
  nixosConfigurations = nixpkgs.lib.genAttrs systemNames (name: (config (systems.${name} // {hostname = name;})));
}
