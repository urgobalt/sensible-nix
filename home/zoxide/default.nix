{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.zoxide;
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

    programs.fish.shellInit = ''
      ${lib.getExe pkgs.zoxide} init fish | source
    '';
  };
}
