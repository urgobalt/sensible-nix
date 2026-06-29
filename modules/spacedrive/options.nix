{
  lib,
  sensible_option,
  ...
}:
with lib;
  sensible_option {
    spacedrive = {
      enable = mkEnableOption "Spacedrive file manager";
    };
  }
