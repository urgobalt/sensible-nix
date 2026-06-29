{
  lib,
  pkgs,
  sensible_option,
  sensibleLib,
  ...
}: with lib;
    sensible_option {
      shell = sensibleLib.mkPackageSelector {
        name = "shell";
        enableDefault = true;
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
      sysinfo = sensibleLib.mkPackageSelector {
        name = "sysinfo";
        enableDefault = true;
        packages = {
          none = {
            name = "none";
            description = "no sysinfo package";
            package = pkgs.emptyDirectory;
          };
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
      zoxide = {
        enable = mkOption {
          type = types.bool;
          default = true;
          description = "Enable zoxide and override the default cd alias to call zoxide.";
        };
      };
    }
