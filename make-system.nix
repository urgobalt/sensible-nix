{pkgs,inputs}:
{
  user,
  full-name,
  wallpaper ? ./assets/wallpaper.png,
  nvim-config,
  system-secrets ? /etc/nixos/secrets/system.nix,
  home-secrets ? /etc/nixos/secrets/home.nix,
  host-base ? /etc/nixos/hosts,
  sshPath ? /etc/nixos/ssh.nix,
  ...
}: hostname: {
  system,
  extraModules ? [],
  specialArgs ? {},
  disko ? false,
  wsl ? false,
}:
let host = file: (host-base + "/${hostname}/${file}");
in
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
      (host "system.nix")
      # Secret management within nixos, many things depend on them
      inputs.agenix.nixosModules.default
      system-secrets
      # Home manager is the thing modularizing the configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          backupFileExtension = "bkp";
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {
            inherit full-name user wallpaper nvim-config;
            inherit (inputs) agenix;
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
      inherit user full-name wallpaper;
      inherit (inputs) agenix;
      ssh = import sshPath;
    }
    // specialArgs;
}
