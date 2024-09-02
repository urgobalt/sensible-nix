{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems = {
      url = "github:nix-systems/default";
      flake = false;
    };
    nur.url = "github:nix-community/nur";

    # Hardware
    wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Partitions as code
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };
  outputs = {
    nixpkgs,
    agenix,
    systems,
    ...
  } @ inputs: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    nixosModules.mkSystem = import ./make-system.nix {inherit nixpkgs inputs;};
    packages = eachSystem (system: {
      agenix = agenix.packages.${system}.agenix;
    });
  };
}

