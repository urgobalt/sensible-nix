{
  pkgs,
  lib,
  config,
  user,
  wallpaper,
  ...
}:
with lib; let
  cfg = config.modules.display-manager;
in {
  options.modules.display-manager = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable the sddm display manager.";
    };
    theme = {
      package = mkOption {
        type = types.package;
        default = pkgs.sddm-glassy;
        description = "The package that contain the theme.";
      };
      name = mkOption {
        type = types.str;
        default = "sddm-glassy";
        description = "The name of the package. It is the name of the folder within /share/sddm/themes.";
      };
      extraPackages = mkOption {
        type = with types; listOf package;
        default = with pkgs.libsForQt5; [
          qt5.qtgraphicaleffects
          plasma-workspace
          plasma-framework
          kconfig
        ];
        description = "Extra Qt plugins and/or QML libraries to add to the environment.";
      };
    };
  };
  config =
    mkIf cfg.enable
    {
      environment.systemPackages = [cfg.theme.package];
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };
      services.displayManager.sddm = {
        enable = true;
        extraPackages = cfg.theme.extraPackages;
        theme = cfg.theme.name;
        wayland.enable = true;
      };
      boot.plymouth.enable = true;
    };
}
