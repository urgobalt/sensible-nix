{
  lib,
  config,
  pkgs,
  sensible_option,
  sensibleLib,
  ...
}: let
  packageSelector = sensibleLib.mkPackageSelector config;
in
  with lib;
    sensible_option {
      shell = packageSelector {
        name = "shell";
        packages = {
          fish = {
            name = "fish";
            description = "fish shell";
            package = pkgs.fish;
          };
          bash = {
            name = "bash";
            description = "bash shell";
            package = pkgs.bash;
          };
          zsh = {
            name = "zsh";
            description = "zsh shell";
            package = pkgs.zsh;
          };
        };
      };
      sysinfo = packageSelector {
        name = "sysinfo";
        packages = {
          pfetch = {
            name = "pfetch";
            description = "pfetch sysinfo";
            package = pkgs.pkgs.pfetch-rs;
          };
          fastfetch = {
            name = "fastfetch";
            description = "fastfetch sysinfo";
            package = pkgs.fastfetch;
          };
        };
      };
      starship = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = "Customizable shell prompt that works on bash, zsh, fish and many others.";
        };
      };
      options.modules.zoxide = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable zoxide and override the default cd alias to call zoxide.";
        };
      };
    }
