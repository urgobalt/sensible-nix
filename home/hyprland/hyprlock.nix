{
  cfg,
  config,
  lib,
  wallpaper,
  colors,
}: let
  defaultLabelFont = "SourceCodePro";
  modules = config.modules;
in {
  general = {
    grace = 1;
    ignore_empty_input = false;
  };
  animations = {
    bezier = "linear, 1, 1, 0, 0";
    animation = "fade, 1, 1.8, linear";
  };
  background = {
    monitor = "";
    path = builtins.toString wallpaper;
    color = "rgba(25, 20, 20, 0.2)";
    blur_size = 2;
    blur_passes = 6;
    noise = 0.05;
    contrast = 1;
    brightness = 0.7;
    vibrancy = 0.3;
    vibrancy_darkness = 0.0;
  };

  input-field = {
    monitor = "";
    size = "100,40";
    outline_thickness = 0;
    dots_size = 0.05;
    dots_spacing = 0.15;
    dots_center = true;
    dots_rounding = -1;
    outer_color = colors.black;
    inner_color = colors.text;
    font_color = colors.gray02;
    fade_on_empty = false;
    fade_timeout = 1000;
    placeholder_text = "<i>Input Password...</i>";
    hide_input = false;
    rounding = 100;
    check_color = colors.blue;
    fail_color = colors.red;
    fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
    capslock_color = -1; # this needs to look better
    numlock_color = -1;
    bothlock_color = -1;
    invert_numlock = false;
    swap_font_color = false;
    position = "0, -40";
    halign = "center";
    valign = "center";
    shadow_passes = 10;
    shadow_size = 20;
    shadow_color = colors.black;
    shadow_boost = 1.6;
  };

  label = [
    {
      monitor = "";
      text = "cmd[update:1000] echo \"<b><big> \"$(date +'%H:%M:%S')\" </big></b>\"";
      font_size = 12;
      position = "0, -5";
      halign = "center";
      valign = "top";
      color = colors.text;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "cmd[update:18000000] echo \"$(date +'%A, %-d %B %Y')\"";
      font_size = 10;
      position = "-5, 5";
      halign = "right";
      valign = "bottom";
      color = colors.text;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "cmd[update:18000000] echo \"$(date +'Week %U')\"";
      font_size = 10;
      position = "5, 5";
      halign = "left";
      valign = "bottom";
      color = colors.text;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "  ${config.home.username}";
      font_size = 12;
      position = "0, 5";
      halign = "center";
      valign = "center";
      color = colors.text;
      font_family = defaultLabelFont;
    }
    {
      monitor = "";
      text = "I use Sensible-Nix btw";
      font_size = 10;
      position = "0, -100";
      halign = "center";
      valign = "center";
      color = colors.text;
      font_family = defaultLabelFont;
    }
    {
      # Caps Lock Warning
      monitor = "";
      text = "cmd[update:250] sh ${./check-capslock.sh}";
      color = colors.red;
      font_size = 10;
      font_family = defaultLabelFont;
      position = "0, -80";
      halign = "center";
      valign = "center";
    }
    {
      monitor = "";
      text = "cmd[update:60000] echo \"$(sh ${./uptimeNixOS.sh})\"";
      font_size = 10;
      position = "0, 5";
      halign = "center";
      valign = "bottom";
      color = colors.text;
      font_family = defaultLabelFont;
    }
  ];

  # image = {
  #   monitor = "";
  #   path = toString modules.hyprland.avatar;
  #   size = 280;
  #   rounding = 40;
  #   border_size = 4;
  #   border_color = colors.blue;
  #   rotate = 0;
  #   reload_time = -1;
  #   position = "0, 200";
  #   halign = "center";
  #   valign = "center";
  #   shadow_passes = 10;
  #   shadow_size = 20;
  #   shadow_color = colors.black;
  #   shadow_boost = 1.6;
  # };
}
