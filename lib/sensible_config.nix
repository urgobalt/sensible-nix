lib: user: config: {
  imports =
    if builtins.hasAttr "imports" config
    then config.imports
    else [];
  config =
    lib.mkIf config.condition
    ({
        assertions =
          if builtins.hasAttr "assertions" config
          then config.assertions
          else [];
        warnings =
          if builtins.hasAttr "warnings" config
          then config.warnings
          else [];
        home-manager.users.${user} =
          lib.mkIf config.condition
          (
            if builtins.hasAttr "home" config
            then config.home
            else {}
          );
      }
      // (
        if builtins.hasAttr "system" config
        then config.system
        else {}
      ));
}
