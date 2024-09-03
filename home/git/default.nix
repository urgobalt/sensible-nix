{
  pkgs,
  lib,
  config,
  full-name,
  email,
  ...
}:
with lib; let
  cfg = config.modules.git;
in {
  options.modules.git = {enable = mkEnableOption "git";};
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = full-name;
      userEmail = email;
      extraConfig = {
        core.editor = "nvim";
        safe.directory = [
          "/etc/nixos"
        ];
        push.autoSetupRemote = true;
      };
    };
  };
}
