{
  lib,
  config,
  ...
}: {
  assertions = [
    {
      assertion = let
        systems = builtins.attrValues config.systems;
        all_systems_have_usernames = lib.lists.foldl (b: e: b && e.username != null) true systems;
      in
        all_systems_have_usernames || config.default_username != null;
      message = "Default username must be set if username is not set on all systems.";
    }
  ];
  options = with lib; let
    system = {
      username = mkOption {
        default = null;
        type = with types; nullOr str;
        description = "The username on the system.";
      };
      modules = mkOption {
        default = [];
        type = with types; listOf (either path attrs);
        description = "Modules that configures your system.";
      };
      specialArgs = mkOption {
        default = {};
        type = types.attrs;
        description = "Extra arguments passed to the modules of your system.";
      };
    };
  in {
    default_username = mkOption {
      default = null;
      type = with types; nullOr str;
      description = "The default username of your administrator account on each system.";
    };
    systems = mkOption {
      type = types.submodule system;
      description = "The systems configured by hostname. Note: The hostname of your system is automatically set to the key of the attribute set.";
    };
  };
}
