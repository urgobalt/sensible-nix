{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zoxide;
  shellAliases = {
    "cd" = "z";
  };
in {
  options.modules.zoxide = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable zoxide and override the default cd alias to call zoxide.";
    };
  };
  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    programs.fish.shellAbbrs = shellAliases;
    programs.zsh.shellAliases = shellAliases;
    programs.bash.shellAliases = shellAliases;
  };
}
