input @ {
  user,
  lib,
  ...
}: module: let
  configuration = module input;
in {
  config = lib.mkIf configuration.condition ({
      home-manager.users.${user} =
        if (builtins.hasAttr "home" configuration)
        then configuration.home
        else {};
    }
    // (
      if (builtins.hasAttr "system" configuration)
      then configuration.system
      else {}
    ));
}
