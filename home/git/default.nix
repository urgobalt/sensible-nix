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
        core = {
          editor = "nvim";
          fsmonitor = true;
          untrackedCache = true;
        };
        gpg.format = "ssh";
        safe.directory = [
          "/etc/nixos"
        ];
        push.autoSetupRemote = true;
        rerere.enabled = true;
        column.ui = "auto";
        branch.sort = "-committerdate";
        fetch.writeCommitGraph = true;
      };
      aliases = {
        fp = "push --force-with-lease";
      };
    };
  };
}
