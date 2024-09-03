{
  description = "A example usecase of the flake.nix";
  inputs.sensible-nix.url = "../";
  outputs = {
    self,
    sensible-nix,
  }: let
    mkSystem = sensible-nix.nixosModules.mkSystem {
      outPath = self.outPath;
      user = "test";
      full-name = "Testing";
      email = "test@test.com";
      nvim-config = ./.;
    };
  in {
    nixosConfigurations.examplehost = mkSystem "examplehost" {
      system = "x86_64-linux";
    };
  };
}
