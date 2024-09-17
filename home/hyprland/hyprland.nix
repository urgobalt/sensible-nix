{
  cfg,
  colors,
}: {
  monitor = cfg.monitors ++ [",addreserved,40,0,0,0"];
  # "swaybg -i /home/urgobalt/pictures/wallpaper.png"
  # "eww daemon" "eww open bar"
  exec-once = ["wlsunset -l -23 -L -46" "eww daemon" "eww open bar" "hyprkool daemon -m" "wl-paste --watch cliphist store" "dunst --startup_notification"];
  input = {
    follow_mouse = 2;
    kb_layout = "se";
    sensitivity = 1;
    natural_scroll = false;
  };
  general = {
    layout = "master";
    gaps_in = 5;
    gaps_out = 15;
    border_size = 1;
    "col.active_border" = colors.yellow;
    "col.inactive_border" = colors.none;
  };
  master = {
    mfact = 0.6;
    inherit_fullscreen = 1;
    no_gaps_when_only = 0;
    orientation = "center";
    always_center_master = false;
    new_status = "master";
  };
  misc = {
    disable_splash_rendering = true;
    disable_hyprland_logo = true;
  };
  decoration = {
    rounding = 5;
    drop_shadow = 0;
    shadow_range = 60;
    "col.shadow" = colors.gray02;
    inactive_opacity = 1.0;
  };
  plugin = {
    # overview = {
    #   workspaceActiveBorder = colors.yellow;
    #   workspaceBorder = colors.gray02;
    #   overrideGaps = false;
    #   affectStrut = false;
    # };
    hyprkool = {
      overview = {
        hover_border_color = colors.yellow;
        focus_border_color = colors.yellow;
        workspace_gap_size = 5;
      };
    };
  };
  animations = {
    enabled = 1;
    animation = [
      "windows,1,3,default,slide"
      "workspaces,1,2,default,slide"
      "windowsIn,1,3,default,popin"
    ];
  };

  "$mod" = "SUPER";
  "$smod" = "SUPER SHIFT";
  "$cmod" = "CTRL SUPER";
  bind = [
    # General
    "$mod,Q,killactive,"
    "$smod,F,togglefloating,"
    "$mod,F,fullscreen,0"
    "$mod,Tab,exec,hyprkool toggle-overview"
    "CTRL SHIFT,Escape,exec,kitty btop"
    # Applications
    "$mod,R,exec,rofi -show drun"
    "$mod,V,exec,cliphist list | rofi -dmenu | cliphist decode | wl-copy"
    "$mod,T,exec,kitty"
    "$mod,B,exec,chromium"
    # Movement
    "$mod,n,layoutmsg,rollnext"
    "$mod,p,layoutmsg,rollprev"
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
    # Brightness
    ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
    ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
    # Volume
    ",XF86AudioRaiseVolume,exec,pamixer -i 5"
    ",XF86AudioLowerVolume,exec,pamixer -d 5"
  ];
  debug.disable_logs = false;
}
