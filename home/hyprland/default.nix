{
  lib,
  config,
  pkgs,
  wallpaper,
  colors,
  ...
}:
with lib; let
  cfg = config.modules.hyprland;
  c = colors.zero_prefix;
in {
  options.modules.hyprland = {
    enable = mkEnableOption "hyprland";
    monitors = mkOption {
      type = types.listOf types.str;
      default = [",preferred,auto,1"];
      description = "The monitors registred into hyprland.";
    };
    layout = mkOption {
      type = with types; enum ["master" "dwindle"];
      default = "master";
      description = "The initial layout that hyprland has at boot. May be changed using dispatchers.";
    };
    terminal = mkOption {
      type = with types; package;
      default = pkgs.kitty;
      description = "The terminal that is used to run most terminal dependant commands and binds in hyprland.";
    };
    browser = mkOption {
      type = with types; package;
      default = pkgs.firefox;
      description = "The browser that is used by default in hyprland commands and binds.";
    };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      swaybg
      wlsunset
      wl-clipboard
      cliphist
      hyprkool-bin
      # unstable.hyprpaper
      # unstable.hyprland
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.variables = ["--all"];
      xwayland.enable = true;
      plugins = with pkgs; [
        # hyprspace
        hyprkool-plugin
      ];
      settings = import ./hyprland.nix {
        inherit cfg lib config;
        colors = c;
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = ["${wallpaper}"];
        wallpaper = [
          ",${wallpaper}"
        ];
      };
    };

    # programs.hyprlock = {
    #   enable = true;
    #   settings = {
    #   };
    # };

    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file."pictures/wallpaper.png".source = ./wallpaper.png;

    xdg.configFile."hypr/hyprkool.toml".source = ./hyprkool.toml;
  };
}
