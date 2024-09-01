{
  pkgs,
  user,
  fullName,
  inputs,
  wallpaper,
  nvim-config,
  ...
}: hostname: {
  system,
  extraModules ? [],
  specialArgs ? {},
  disko ? false,
  wsl ? false,
}:
pkgs.lib.nixosSystem {
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
      (./. + "/hosts/${hostname}/system.nix")
      # Secret management within nixos, many things depend on them
      inputs.agenix.nixosModules.default
      ./secrets
      # Home manager is the thing modularizing the configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          backupFileExtension = "bkp";
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit fullName user wallpaper nvim-config;
            inherit (inputs) agenix;
            hyprspace = inputs.hyprspace.packages.${system}.default;
            hyprland = inputs.hyprland.packages.${system}.default;
          };

          users.${user}.imports = [
            # User defined modules
            ./home
            # Secrets
            inputs.agenix.homeManagerModules.default
            ./secrets/home.nix
            # Host configuration
            (./. + "/hosts/${hostname}/user.nix")
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
              unstable = import inputs.pkgs-unstable {
                system = system;
                config.allowUnfree = true;
              };
            })
            (import ./overlays)
          ];
          config = {
            allowUnfreePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [
                "obsidian"
              ];
            allowInsecurePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [
                "electron"
              ];
          };
        };
      }

      # WSL does not really have hardware
      (
        if (wsl == false)
        then (./. + "/hosts/${hostname}/hardware-configuration.nix")
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
        (./. + "/hosts/${hostname}/disk-config.nix")
      ]
      else []
    )
    ++ extraModules;
  specialArgs =
    {
      inherit user fullName wallpaper;
      inherit (inputs) agenix;
      hyprland = inputs.hyprland.packages.${system}.default;
      ssh = import ./ssh.nix;
    }
    // specialArgs;
}
