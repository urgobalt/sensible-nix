{
  description="A example usecase of the flake.nix";
  inputs.sensible-nix.url="../";
  outputs={sensible-nix,...}:
  let mkSystem = sensible-nix.nixosModules.mkSystem {user="test"; full-name="Testing";nvim-config=./.;};
  in{
    nixosConfigurations.wsl=mkSystem "wsl" {
      system="x86_64-linux";
      wsl=true;
    };
  };
}