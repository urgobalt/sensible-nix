lib: user: unit: let
  optionalWithDefault = default: name:
    if builtins.hasAttr name unit
    then unit.${name}
    else default;
  optional = optionalWithDefault {};
  optionals = optionalWithDefault [];
in {
  imports = optionals "imports";
  config =
    lib.mkIf unit.condition
    <| {
      assertions = optionals "assertions";
      warnings = optionals "warnings";
      home-manager.users.${user} = lib.mkIf unit.condition <| optional "home";
    }
    // optional "system";
}
