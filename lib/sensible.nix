{nixpkgs, ...} @ inputs: attrs: let
  config = let
    config =
      (nixpkgs.lib.evalModules {
        modules = [
          ./assertions.nix
          ./system_config.nix
          attrs
        ];
        specialArgs = inputs;
      }).config;
  in
    (import ./compose.nix) ({
        inherit config;
        lib = nixpkgs.lib;
      }
      // inputs);
in {
  nixosConfigurations = nixpkgs.lib.genAttrs (builtins.attrNames config.systems) (hostname: let
    system = config.systems.${hostname};
  in
    nixpkgs.lib.nixosSystem {
      system = system.system;
      modules =
        config.defaultModules
        ++ system.modules
        ++ (
          nixpkgs.lib.singleton {
            inherit (config) assertions warnings;
          }
        );
      specialArgs =
        config.defaultSpecialArgs
        // system.specialArgs;
    });
}
