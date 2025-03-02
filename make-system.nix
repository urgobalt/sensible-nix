{
  nixpkgs,
  inputs,
}: {
  outPath,
  user,
  full-name,
  email,
  wallpaper ? ./assets/image-sierra.jpg,
  nvim-config,
  system-secrets ? "${outPath}/secrets/system.nix",
  home-secrets ? "${outPath}/secrets/home.nix",
  host-base ? "${outPath}/hosts",
  sshPath ? "${outPath}/ssh.nix",
  ...
}: hostname: {
  system,
  extraModules ? [],
  specialArgs ? {},
  disko ? false,
  wsl ? false,
}: let
  host = file: (host-base + "/${hostname}/${file}");
  lib = nixpkgs.lib.extend (final: prev: {hm = inputs.home-manager.lib.hm;});
  colors = import ./lib/colors.nix;
in
  nixpkgs.lib.nixosSystem {
    system = system;

    modules =
      [
        # Set the hostname for automatic selection of the right system after
        # initial build
        {networking.hostName = hostname;}
        # System configuration that you don't really want to disable
        ./modules/configuration.nix
        # Import the modules that can be enabled
        ./modules
        (host "system.nix")
        # Secret management within nixos, many things depend on them
        inputs.agenix.nixosModules.default
        system-secrets
        # Nix index database
        inputs.nix-index-database.nixosModules.nix-index
        # Home manager is the thing modularizing the configuration
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            backupFileExtension = "bkp";
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {
              inherit full-name user email wallpaper nvim-config colors;
              inherit (inputs) agenix;
              ssh = import sshPath;
            };

            users.${user}.imports = [
              # User defined modules
              ./home
              # Secrets
              inputs.agenix.homeManagerModules.default
              home-secrets
              # Host configuration
              (host "user.nix")
            ];
          };
        }
        # Overlays
        {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [
              (final: prev: {
                nur = import inputs.nur {
                  nurpkgs = prev;
                  pkgs = prev;
                };
              })
              (final: prev: {
                unstable = import inputs.nixpkgs-unstable {
                  system = system;
                  config.allowUnfree = true;
                };
              })
              (import ./overlays)
            ];
            config = {
              allowUnfreePredicate = pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "obsidian"
                ];
              allowInsecurePredicate = pkg:
                builtins.elem (nixpkgs.lib.getName pkg) [
                  "electron"
                ];
            };
          };
        }

        # WSL does not really have hardware
        (
          if (wsl == false)
          then (host "hardware-configuration.nix")
          else {}
        )
      ]
      # Add WSL utils to make sure that it functions correctly within WSL
      ++ (
        if wsl
        then [
          inputs.wsl.nixosModules.wsl
          {
            wsl.enable = true;
            wsl.defaultUser = user;
          }
        ]
        else []
      )
      # If you want to manage the system partitions using disko.
      # Mostly an option since you might use somethng other
      # than disko to partition the drive.
      ++ (
        if disko
        then [
          inputs.disko.nixosModules.disko
          (host "disk-config.nix")
        ]
        else []
      )
      ++ extraModules;
    specialArgs =
      {
        inherit lib user full-name wallpaper colors;
        inherit (inputs) agenix;
        ssh = import sshPath;
      }
      // specialArgs;
  }
