{
  description = "The entrypoint to the system configuration";
  inputs = {
    # System
    pkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    pkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default";
    nur.url = "github:nix-community/nur";

    # Hardware
    wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "pkgs";
    };
    hardware.url = "github:NixOS/nixos-hardware";

    # Partitions as code
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "pkgs";
    };

    # Home
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "pkgs";
    };

    # Secrets
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "pkgs";
    };
  };
  outputs = {
    pkgs,
    hardware,
    ...
  } @ inputs: {
    nixosModules.mkSystem=(import ./make-system.nix {inherit pkgs inputs;});
  };
}