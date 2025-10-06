{
  lib,
  config,
  pkgs,
  sensible_option,
  mkPackageSelector,
  ...
}:
let packageSelector = mkPackageSelector config; in
with lib;
  sensible_option {
    shell = packageSelector {
      name = "browser";
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
        description = "Customizable shell that works on bash, zsh, fish and many others.";
      };
    };
  }
