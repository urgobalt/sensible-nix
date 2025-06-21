{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
    sensible = {
      url = "path:../";
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
      systems = {
        test = {
          system = "x86_64-linux";
          stateVersion = "25.05";
          disko = true;
          modules = [
            ./hardware-configuration.nix
            ./disk-config.nix
          ];
        };
        # The following system enables as many options as possible
        testBench = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {inherit system;};
        in {
          system = system;
          stateVersion = "25.05";
          packages = [pkgs.fish];
          disko = true;
          modules = [
            ./hardware-configuration.nix
            ./disk-config.nix
            ./modules.nix
          ];
        };
      };
    };
}
