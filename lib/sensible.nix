{nixpkgs, ...} @ inputs: attrs: let
  config = import ./compose.nix <| {
      config =
        (nixpkgs.lib.evalModules {
          modules = [
            ./system_config.nix
            attrs
          ];
          specialArgs = inputs;
        }).config;
      lib = nixpkgs.lib;
    }
    // inputs;
in {
  nixosConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames config.systems) (hostname: let
    system = config.systems.${hostname};
  in
    nixpkgs.lib.nixosSystem {
      system = system.system;
      modules =
        config.defaultModules
        ++ system.modules;
      specialArgs =
        config.defaultSpecialArgs
        // system.specialArgs;
    });
}
