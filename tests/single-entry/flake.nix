{
  inputs.sensible.url = "github:urgobalt/sensible-nix";
  outputs = {sensible, ...}:
    sensible.nixosModules.sensible {
      systems.test = {
        username = "test";
        system = "x86_64-linux";
        stateVersion = "25.05";
        modules = [./configuration.nix];
      };
    };
}
