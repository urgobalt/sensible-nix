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
      defaultUsername = "test";
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
        testBench = {
          system = "x86_64-linux";
          stateVersion = "25.05";
          disko = true;
          wsl = true;
          modules = [
            ./hardware-configuration.nix
            ./disk-config.nix
            ./modules.nix
          ];
        };
      };
    };
}
