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
      enableFishIntegration = false; # Alias come before init breaking zoxide
    };

    programs.fish.shellAliases = shellAliases;
    programs.zsh.shellAliases = shellAliases;
    programs.bash.shellAliases = shellAliases;

    programs.fish.shellInit = ''
      ${lib.getExe pkgs.zoxide} init fish | source
    '';
  };
}
