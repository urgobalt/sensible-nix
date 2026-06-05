# for when hyprkool supports lua
{
  cfg,
  config,
  lib,
  colors,
}: let
  modules = config.modules;
  terminal = lib.getExe cfg.terminal;
  browser = lib.getExe cfg.browser;

  # Pre-evaluate autostart commands in Nix
  autostartCmds =
    lib.optionals modules.hyprland.hyprlock.auto_start ["hyprlock || hyprctl dispatch exit"]
    ++ ["wlsunset -l -23 -L -46" "hyprkool daemon" "wl-paste --watch cliphist store"]
    ++ lib.optionals modules.eww.enable ["eww daemon" "eww open bar"]
    ++ lib.optionals modules.dunst.enable ["dunst --startup_notification"]
    ++ lib.optionals modules.swaync.enable ["swaync"]
    ++ lib.optionals modules.waybar.enable ["waybar"]
    ++ lib.optionals modules.social.enable ["[workspace special:vesktop silent] vesktop --fullscreen"]
    ++ lib.optionals modules.hyprland.live_wallpaper.auto_start ["mpvpaper -f -o \"loop no-audio\" ${lib.strings.concatStringsSep "," modules.hyprland.live_wallpaper.monitors} $(${modules.hyprland.live_wallpaper.default} sed \"s|~|$HOME|\")"];

  # Pre-evaluate monitor rules in Nix
  allMonitors = cfg.monitors ++ lib.optionals modules.eww.enable [",addreserved,40,0,0,0"];
in {
  extraConfig = ''
    local mod = "SUPER"
    local smod = "SUPER + SHIFT"
    local cmod = "CTRL + SUPER"

    -- ==========================================
    -- Monitors
    -- ==========================================
    ${lib.concatMapStringsSep "\n    " (
        m:
          if lib.hasPrefix ",addreserved" m
          then let
            parts = lib.splitString "," m;
          in "hl.monitor({ output = \"\", reserved_area = { top = ${builtins.elemAt parts 2}, bottom = ${builtins.elemAt parts 3}, left = ${builtins.elemAt parts 4}, right = ${builtins.elemAt parts 5} } })"
          else let
            parts = lib.splitString "," m;
            len = builtins.length parts;
            p1 =
              if len > 0 && builtins.elemAt parts 0 != ""
              then builtins.elemAt parts 0
              else "";
            p2 =
              if len > 1 && builtins.elemAt parts 1 != ""
              then builtins.elemAt parts 1
              else "preferred";
            p3 =
              if len > 2 && builtins.elemAt parts 2 != ""
              then builtins.elemAt parts 2
              else "auto";
            p4 =
              if len > 3 && builtins.elemAt parts 3 != ""
              then builtins.elemAt parts 3
              else "1";
          in "hl.monitor({ output = \"${p1}\", mode = \"${p2}\", position = \"${p3}\", scale = ${p4} })"
      )
      allMonitors}

    -- ==========================================
    -- Autostart
    -- ==========================================
    hl.on("hyprland.start", function()
      ${lib.concatMapStringsSep "\n      " (cmd: "hl.exec_cmd([[${cmd}]])") autostartCmds}
    end)

    -- ==========================================
    -- General Configuration
    -- ==========================================
    hl.config({
      env = {
        "HYPRCURSOR_THEME,${cfg.cursor.name}",
        "HYPRCURSOR_SIZE,${builtins.toString cfg.cursor.size}"
      },
      input = {
        follow_mouse = 2,
        kb_layout = "se",
        sensitivity = 1,
        natural_scroll = false,
        special_fallthrough = true
      },
      general = {
        layout = "${cfg.layout}",
        gaps_in = 5,
        gaps_out = { top = 0, right = 20, bottom = 20, left = 20 },
        border_size = 1,
        ["col.active_border"] = "${colors.none}",
        ["col.inactive_border"] = "${colors.none}",
        resize_on_border = false,
        snap = {
          enabled = true,
          window_gap = 20,
          monitor_gap = 5
        }
      },
      master = {
        mfact = 0.5,
        orientation = "center",
        slave_count_for_center_master = 2,
        new_status = "master"
      },
      group = {
        merge_floated_into_tiled_on_groupbar = true
      },
      decoration = {
        rounding = 5,
        shadow = {
          enabled = false,
          range = 30,
          color = "0x66000000"
        },
        inactive_opacity = 0.95,
        active_opacity = 0.95,
        blur = {
          size = 4,
          vibrancy = 1,
          passes = 3
        }
      },
      misc = {
        disable_splash_rendering = true,
        disable_hyprland_logo = true,
        exit_window_retains_fullscreen = true,
        enable_swallow = true,
        swallow_regex = "${lib.strings.getName cfg.terminal}",
        on_focus_under_fullscreen = 1
      },
      animations = {
        enabled = 1,
        animation = {
          "windows,1,3,default,slide",
          "workspaces,1,2,default,slide",
          "windowsIn,1,3,default,popin",
          "layers,1,3,default,fade"
        }
      },
      debug = {
        disable_logs = false
      }
    })

    -- ==========================================
    -- Layer Rules
    -- ==========================================
    hl.layer_rule({ match = { namespace = "eww" }, blur = true })
    hl.layer_rule({ match = { namespace = "eww" }, ignore_alpha = 0.0 })
    hl.layer_rule({ match = { namespace = "swaync" }, blur = true })
    hl.layer_rule({ match = { namespace = "swaync" }, ignore_alpha = 0.0 })
    hl.layer_rule({ match = { namespace = "swaync" }, animation = "slide right" })
    hl.layer_rule({ match = { namespace = "swaync-control-center" }, dim_around = true })
    hl.layer_rule({ match = { namespace = "rofi" }, blur = true })
    hl.layer_rule({ match = { namespace = "rofi" }, ignore_alpha = 0.0 })
    hl.layer_rule({ match = { namespace = "rofi" }, no_anim = true })

    -- ==========================================
    -- Workspace Rules
    -- ==========================================
    hl.workspace_rule({ workspace = "w[t1]", gaps_out = 0, border_size = 0, no_rounding = true })
    hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, border_size = 0, no_rounding = true })

    -- ==========================================
    -- Window Rules
    -- ==========================================
    hl.window_rule({ match = { class = "(steam_app)(.*)" }, tag = "+plain" })
    hl.window_rule({ match = { tag = "plain" }, opacity = "1 override" })
    hl.window_rule({ match = { tag = "plain" }, no_blur = true })
    hl.window_rule({ match = { tag = "plain" }, no_anim = true })

    hl.window_rule({ match = { class = "vesktop" }, workspace = "special:vesktop silent" })
    hl.window_rule({ match = { class = "vesktop" }, fullscreen = true })
    hl.window_rule({ match = { class = "vesktop" }, animation = "fade" })

    hl.window_rule({ match = { initial_class = "steam" }, workspace = "special:steam silent" })
    hl.window_rule({ match = { initial_class = "steam" }, float = true })
    hl.window_rule({ match = { initial_class = "steam" }, animation = "fade" })

    -- ==========================================
    -- Key Binds
    -- ==========================================
    hl.bind(mod .. " + Q", hl.dsp.window.close())
    hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
    hl.bind(smod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
    hl.bind(cmod .. " + F", hl.dsp.window.float({ action = "toggle" }))
    hl.bind("CTRL + SUPER + SHIFT + F", hl.dsp.exec_cmd([[hyprctl dispatch workspaceopt allfloat]]))
    hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd([[${terminal} btop]]))
    hl.bind(smod .. " + z", hl.dsp.exec_cmd([[hypr-zoom -easing=OutBack -easingOut=OutExpo]]))

    hl.bind(mod .. " + T", hl.dsp.exec_cmd([[${terminal}]]))
    hl.bind(mod .. " + B", hl.dsp.exec_cmd([[${browser}]]))
    hl.bind(mod .. " + D", hl.dsp.exec_cmd([[hyprkool toggle-special-workspace --name vesktop]]))
    hl.bind(mod .. " + G", hl.dsp.exec_cmd([[hyprkool toggle-special-workspace --name steam]]))
    hl.bind(mod .. " + X", hl.dsp.exec_cmd([[hyprpicker -a]]))

    hl.bind(mod .. " + n", hl.dsp.layout([[rollnext]]))
    hl.bind(mod .. " + p", hl.dsp.layout([[rollprev]]))
    hl.bind(mod .. " + m", hl.dsp.layout([[focusmaster]]))

    hl.bind("ALT + Tab", hl.dsp.window.cycle_next())
    hl.bind("ALT + Tab", hl.dsp.window.alter_zorder({ mode = "top" }))

    hl.bind(smod .. " + h", hl.dsp.window.move({ direction = "l" }))
    hl.bind(smod .. " + l", hl.dsp.window.move({ direction = "r" }))
    hl.bind(smod .. " + k", hl.dsp.window.move({ direction = "u" }))
    hl.bind(smod .. " + j", hl.dsp.window.move({ direction = "d" }))

    hl.bind(mod .. " + h", hl.dsp.exec_cmd([[hyprkool move-left -c]]))
    hl.bind(mod .. " + l", hl.dsp.exec_cmd([[hyprkool move-right -c]]))
    hl.bind(mod .. " + j", hl.dsp.exec_cmd([[hyprkool move-down -c]]))
    hl.bind(mod .. " + k", hl.dsp.exec_cmd([[hyprkool move-up -c]]))

    hl.bind(smod .. " + h", hl.dsp.exec_cmd([[hyprkool move-left -c -w]]))
    hl.bind(smod .. " + l", hl.dsp.exec_cmd([[hyprkool move-right -c -w]]))
    hl.bind(smod .. " + j", hl.dsp.exec_cmd([[hyprkool move-down -c -w]]))
    hl.bind(smod .. " + k", hl.dsp.exec_cmd([[hyprkool move-up -c -w]]))

    hl.bind("XF86AudioMute", hl.dsp.exec_cmd([[pamixer --toggle-mute]]))
    hl.bind("XF86WLAN", hl.dsp.exec_cmd([[if [ $(wpa_cli status | grep "^wpa_state=" | awk -F '=' '{print $2}') == "COMPLETED" ]; then wpa_cli disconnect; else wpa_cli reconnect; fi]]))

    ${lib.optionalString modules.rofi.enable ''
      hl.bind(mod .. " + R", hl.dsp.exec_cmd([[rofi -show drun]]))
      hl.bind(mod .. " + V", hl.dsp.exec_cmd([[cliphist list | rofi -dmenu | cliphist decode | wl-copy]]))
      hl.bind(smod .. " + X", hl.dsp.exec_cmd([[format=$(echo -ne 'cmyk\nhex\nrgb\nhsl\nhsv' | rofi -dmenu) && sleep 0.7s && hyprpicker -af $format]]))
      hl.bind(mod .. " + S", hl.dsp.exec_cmd([[echo -ne 'active\nscreen\noutput\narea' | rofi -dmenu | xargs -I _ grimblast --notify --freeze copysave _ ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%m-%s).png]]))
      hl.bind(smod .. " + S", hl.dsp.exec_cmd([[grimblast --notify --freeze copysave area ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%m-%s).png]]))
      hl.bind("Print", hl.dsp.exec_cmd([[grimblast --notify --freeze copysave screen ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%m-%s).png]]))
      hl.bind(mod .. " + mouse_up", hl.dsp.exec_cmd([[hyprctl dispatch resizeactive 5% 5%]]))
      hl.bind(mod .. " + mouse_down", hl.dsp.exec_cmd([[hyprctl dispatch resizeactive -5% -5%]]))
    ''}

    ${lib.optionalString modules.waybar.enable ''
      hl.bind(mod .. " + Z", hl.dsp.exec_cmd([[pkill waybar && hyprctl keyword general:gaps_out 5 || { waybar & disown; hyprctl keyword general:gaps_out 0,20,20,20; }]]))
    ''}

    ${lib.optionalString modules.swaync.enable ''
      hl.bind(smod .. " + N", hl.dsp.exec_cmd([[swaync-client -t -sw]]))
    ''}

    ${lib.optionalString (modules.hyprland.live_wallpaper.enable && (builtins.length modules.hyprland.live_wallpaper.monitors) != 0) ''
      hl.bind(mod .. " + u", hl.dsp.exec_cmd([[pkill .mpvpaper-wrapp || mpvpaper -f -o "loop no-audio" ${lib.strings.concatStringsSep "," modules.hyprland.live_wallpaper.monitors} $(zenity --entry --entry-text=${modules.hyprland.live_wallpaper.default} --text="Enter your input:" --title="Input Prompt" 2>/dev/null | sed "s|~|$HOME|")]]))
    ''}

    -- Repeating Binds (binde)
    hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd([[brightnessctl set +5%]]), { repeating = true })
    hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd([[brightnessctl set 5%-]]), { repeating = true })
    hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd([[pamixer -i 5]]), { repeating = true })
    hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd([[pamixer -d 5]]), { repeating = true })
    hl.bind("XF86AudioNext", hl.dsp.exec_cmd([[playerctl next]]), { repeating = true })
    hl.bind("XF86AudioPrev", hl.dsp.exec_cmd([[playerctl previous]]), { repeating = true })
    hl.bind("XF86AudioPlay", hl.dsp.exec_cmd([[playerctl play-pause]]), { repeating = true })

    -- Mouse Binds (bindm)
    hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
    hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
  '';
}
