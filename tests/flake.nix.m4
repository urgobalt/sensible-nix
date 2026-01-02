{
  inputs.sensible.url = "github:urgobalt/sensible-nix";
  outputs = {sensible, ...}:
    sensible.nixosModules.sensible {
      default = {
        username = "test";
        modules = MODULES;
      };
      systems = SYSTEMS;
    };
}
