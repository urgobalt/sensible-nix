{
  config,
  lib,
  sensibleLib,
}: let
  default = import ./hyprland-default.nix {inherit config lib;};
  terminal = lib.getExe <| sensibleLib.getDefaultPackage config.sensible.terminal;
  browser = lib.getExe <| sensibleLib.getDefaultPackage config.sensible.browser;
  colors = config.lib.stylix.colors;
in {
  monitor = config.sensible.monitors;
  # "swaybg -i /home/urgobalt/pictures/wallpaper.png"
  # "eww daemon" "eww open bar"
  exec-once = default.exec-once ++ config.sensible.hyprland.exec-once;
  # TODO: allow for setting a custom cursor using the rewrite
  #
  # env = ["HYPRCURSOR_THEME,${config.sensible.cursor.name}" "HYPRCURSOR_SIZE,${builtins.toString config.sensible.cursor.size}"];

  general = {
    layout = config.sensible.hyprland.layout;
  };
  group = {
    merge_floated_into_tiled_on_groupbar = true;
  };
  decoration = {
    rounding = 5;
    shadow = {
      enabled = "false";
      range = 30;
    };
    inactive_opacity = 0.95;
    active_opacity = 0.95;
    blur = {
      size = 4;
      vibrancy = 1;
      passes = 3;
    };
  };
  plugin = {
    # overview = {
    #   workspaceActiveBorder = colors.base0A;
    #   workspaceBorder = colors.base03;
    #   overrideGaps = false;
    #   affectStrut = false;
    # };
    hyprkool = {
      overview = {
        hover_border_color = colors.base0A;
        focus_border_color = colors.base0A;
        workspace_gap_size = 5;
      };
    };
  };
  misc = {
    disable_splash_rendering = true;
    disable_hyprland_logo = true;
    exit_window_retains_fullscreen = true;
    enable_swallow = true;
    swallow_regex = "${lib.strings.getName <| sensibleLib.getDefaultPackage config.sensible.terminal}";
  };
  animations = {
    enabled = 1;
    animation = [
      "windows,1,3,default,slide"
      "workspaces,1,2,default,slide"
      "windowsIn,1,3,default,popin"
      "layers,1,3,default,fade"
    ];
  };

  workspace = [
    "w[t1], gapsout:0"
    "w[t1], border:0"
    "w[t1], rounding:0"
    "f[1], gapsout:0"
    "f[1], border:0"
    "f[1], rounding:0"
  ];

  windowrulev2 = [
    # Window tags
    "tag +plain,class:(steam_app)(.*)"

    # Rules
    "opacity 1 override, tag:plain"
    "noblur, tag:plain"
    "noanim, tag:plain"

    # Discord
    "workspace special:discord silent, class:discord"
    "fullscreen, class:discord"
    "suppressevent movewindow movewindowv2, class:discord"
    "animation fade, class:discord"
  ];

  "$mod" = "SUPER";
  "$smod" = "SUPER SHIFT";
  "$cmod" = "CTRL SUPER";
  bind =
    [
      # General
      "$mod,Q,killactive,"
      "$mod,F,fullscreen,1"
      "$smod,F,fullscreen,0"
      "$cmod,F,togglefloating,"
      "CTRL SUPER SHIFT,F,exec, hyprctl dispatch workspaceopt allfloat"
      "CTRL SHIFT,Escape,exec,${terminal} btop"
      "$smod,z,exec,hypr-zoom -easing=OutBack -easingOut=OutExpo"
      # Applications
      "$mod,T,exec,${terminal}"
      "$mod,B,exec,${browser}"
      "$mod,D,exec, hyprkool toggle-special-workspace --name discord"
      "$mod,X,exec,hyprpicker -a"
      # Movement
      "$mod,n,layoutmsg,rollnext"
      "$mod,p,layoutmsg,rollprev"
      "$mod,m,layoutmsg,focusmaster"
      # Focus switching
      "ALT,Tab,cyclenext"
      "ALT,Tab,bringactivetotop"
      # Move window
      "$smod,h,movewindow,l"
      "$smod,l,movewindow,r"
      "$smod,k,movewindow,u"
      "$smod,j,movewindow,d"
      # Workspace navigation
      # "$mod,1,workspace,1"
      # "$mod,2,workspace,2"
      # "$mod,3,workspace,3"
      # "$mod,4,workspace,4"
      # "$mod,5,workspace,5"
      # Relative workspace navigation
      # "$mod,l,workspace,+1"
      # "$mod,h,workspace,-1"
      "$mod, h, exec, hyprkool move-left -c"
      "$mod, l, exec, hyprkool move-right -c"
      "$mod, j, exec, hyprkool move-down -c"
      "$mod, k, exec, hyprkool move-up -c"
      # Move to workspace
      # "$smod,1,movetoworkspacesilent,1"
      # "$smod,2,movetoworkspacesilent,2"
      # "$smod,3,movetoworkspacesilent,3"
      # "$smod,4,movetoworkspacesilent,4"
      # "$smod,5,movetoworkspacesilent,5"
      "$smod, h, exec, hyprkool move-left -c -w"
      "$smod, l, exec, hyprkool move-right -c -w"
      "$smod, j, exec, hyprkool move-down -c -w"
      "$smod, k, exec, hyprkool move-up -c -w"
      # Volume
      ",XF86AudioMute,exec,pamixer --toggle-mute"
      # Airplane mode
      ",XF86WLAN,exec,if [ \$(wpa_cli status | grep \"^wpa_state=\" | awk -F '=' '{print \$2}') == \"COMPLETED\" ]; then wpa_cli disconnect; else wpa_cli reconnect; fi"
    ]
    ++ config.sensible.hyprland.keymaps;
  # Repeating keybinds
  binde = [
    # Brightness
    ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
    ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
    # Volume
    ",XF86AudioRaiseVolume,exec,pamixer -i 5"
    ",XF86AudioLowerVolume,exec,pamixer -d 5"
  ];
  bindm = [
    # Floating windows movement and resize
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
  debug.disable_logs = ! config.sensible.hyprland.debug;
}
