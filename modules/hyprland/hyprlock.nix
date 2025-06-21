{
  config,
  lib,
  wallpaper,
}: let
  #  _                      _            _
  # | |__  _   _ _ __  _ __| | ___   ___| | __
  # | '_ \| | | | '_ \| '__| |/ _ \ / __| |/ /
  # | | | | |_| | |_) | |  | | (_) | (__|   <
  # |_| |_|\__, | .__/|_|  |_|\___/ \___|_|\_\
  #        |___/|_|
  defaultLabelFont = "SourceCodePro";
  colors = config.lib.stylix.colors;
in {
  general = {
    grace = 1;
    ignore_empty_input = true;
  };
  animations = {
    bezier = "linear, 1, 1, 0, 0";
    animation = "fade, 1, 1.8, linear";
  };
  background = {
    monitor = "";
    path = "screenshot";
    blur_passes = 4;
    noise = 0.0117;
    contrast = 1.3;
    brightness = 0.8;
    vibrancy = 0.21;
    vibrancy_darkness = 0.0;
  };

  "input-field" = {
    monitor = "";
    size = "360, 50";
    outline_thickness = 3;
    dots_size = 0.33;
    dots_spacing = 0.15;
    dots_center = true;
    dots_rounding = -1;
    outer_color = colors.base00;
    inner_color = colors.base05;
    font_color = colors.base04;
    fade_on_empty = true;
    fade_timeout = 1000;
    placeholder_text = "<i>Input Password...</i>";
    hide_input = false;
    rounding = 40;
    check_color = colors.base0D;
    fail_color = colors.base08;
    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
    capslock_color = -1; # this needs to look better
    numlock_color = -1;
    bothlock_color = -1;
    invert_numlock = false;
    swap_font_color = false;
    position = "0, -80";
    halign = "center";
    valign = "center";
    shadow_passes = 10;
    shadow_size = 20;
    shadow_color = colors.base00;
    shadow_boost = 1.6;
  };

  label = [
    {
      monitor = "";
      text = "cmd[update:18000000] echo \"<b> \"$(date +'%A, %-d %B %Y')\" </b>\"";
      font_size = 34;
      position = "0, 0";
      halign = "right";
      valign = "bottom";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "cmd[update:18000000] echo \"<b> \"$(date +'Week %U')\" </b>\"";
      font_size = 24;
      position = "-200, 50";
      halign = "right";
      valign = "bottom";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "cmd[update:1000] echo \"<b><big> \"$(date +'%H:%M:%S')\" </big></b>\"";
      font_size = 94;
      position = "0, 0";
      halign = "center";
      valign = "top";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "  ${config.home.username}";
      font_size = 24;
      position = "0, 20";
      halign = "center";
      valign = "center";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "I use Sensible-Nix btw";
      font_size = 24;
      position = "0, -20";
      halign = "center";
      valign = "center";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "cmd[update:60000] echo \"<b> \"$(sh ${./uptimeNixOS.sh})\" </b>\"";
      font_size = 24;
      position = "0, -200";
      halign = "center";
      valign = "center";
      color = colors.base05;
      font_family = defaultLabelFont;
    }
  ];

  image = {
    monitor = "";
    path = wallpaper;
    size = 280;
    rounding = 40;
    border_size = 4;
    border_color = colors.base0D;
    rotate = 0;
    reload_time = -1;
    position = "0, 200";
    halign = "center";
    valign = "center";
    shadow_passes = 10;
    shadow_size = 20;
    shadow_color = colors.base00;
    shadow_boost = 1.6;
  };
}
