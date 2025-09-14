{nixpkgs, ...} @ inputs: attrs: let
  config =
    (nixpkgs.lib.evalModules {
      modules = [
        ./assertions.nix
        ./system_config.nix
        attrs
      ];
      specialArgs = inputs;
    }).config;
in {
  nixosConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames config._systems) (hostname: let
    system = config._systems.${hostname};
  in
    nixpkgs.lib.nixosSystem {
      system = system.system;
      modules = config.defaultModules ++ system.modules;
      specialArgs =
        config.defaultSpecialArgs
        // system.specialArgs;
    });
}
