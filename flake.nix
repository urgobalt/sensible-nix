{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems = {
      url = "github:nix-systems/default-linux";
      flake = false;
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

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
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix?ref=release-25.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
  };
  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    systems,
    ...
  }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    nixosModules = rec {
      sensible = import ./lib/sensible.nix inputs;
      default = sensible;
    };
    devShells = eachSystem (system: let
      pkgs = import nixpkgs-unstable {inherit system;};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          nh
          gum
          just
          jq
          m4
          alejandra
          nix-doc
          (callPackage ./overlays/shell.nix {})
        ];
      };
    });
  };
}
