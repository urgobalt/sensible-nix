{
  inputs.sensible.url = "github:urgobalt/sensible-nix";
  outputs = {sensible, ...}:
    sensible.nixosModules.sensible {
      default = {
        username = "test";
        modules = [./configuration.nix];
      };
      systems = {
        test = {
          system = "x86_64-linux";
          stateVersion = "25.05";
        };
        test2 = {
          system = "x86_64-linux";
          stateVersion = "25.05";
        };
      };
    };
}
