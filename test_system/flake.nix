{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    sensible = {
      url = "github:urgobalt/sensible-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    sensible,
    nixpkgs,
    ...
  }:
    sensible.nixosModules.sensible {
      user = "test";
      ssh = {
        users = [];
      };
      systems = {
        test = {
          system = "x86_64-linux";
          disko = true;
          modules = [
            ./hardware-configuration.nix
            ./disk-config.nix
          ];
        };
        test2 = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {inherit system;};
        in {
          system = system;
          packages = [pkgs.fish];
          disko = true;
          modules = [
            ./hardware-configuration.nix
            ./disk-config.nix
          ];
        };
      };
    };
}
