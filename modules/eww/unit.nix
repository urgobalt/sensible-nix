{
  config,
  pkgs,
  sensibleLib,
  ...
}:
let
  colors = config.lib.stylix.colors;
  colorsScss = ''
    :root {
      --base00: #${colors.base00};
      --base00-rgb: ${colors.base00-rgb};
      --base01: #${colors.base01};
      --base01-rgb: ${colors.base01-rgb};
      --base02: #${colors.base02};
      --base02-rgb: ${colors.base02-rgb};
      --base03: #${colors.base03};
      --base03-rgb: ${colors.base03-rgb};
      --base04: #${colors.base04};
      --base04-rgb: ${colors.base04-rgb};
      --base05: #${colors.base05};
      --base05-rgb: ${colors.base05-rgb};
      --base06: #${colors.base06};
      --base06-rgb: ${colors.base06-rgb};
      --base07: #${colors.base07};
      --base07-rgb: ${colors.base07-rgb};
      --base08: #${colors.base08};
      --base08-rgb: ${colors.base08-rgb};
      --base09: #${colors.base09};
      --base09-rgb: ${colors.base09-rgb};
      --base0A: #${colors.base0A};
      --base0A-rgb: ${colors.base0A-rgb};
      --base0B: #${colors.base0B};
      --base0B-rgb: ${colors.base0B-rgb};
      --base0C: #${colors.base0C};
      --base0C-rgb: ${colors.base0C-rgb};
      --base0D: #${colors.base0D};
      --base0D-rgb: ${colors.base0D-rgb};
      --base0E: #${colors.base0E};
      --base0E-rgb: ${colors.base0E-rgb};
      --base0F: #${colors.base0F};
      --base0F-rgb: ${colors.base0F-rgb};
      --base10: #${colors.base10};
      --base10-rgb: ${colors.base10-rgb};
      --base11: #${colors.base11};
      --base11-rgb: ${colors.base11-rgb};
      --base12: #${colors.base12};
      --base12-rgb: ${colors.base12-rgb};
      --base13: #${colors.base13};
      --base13-rgb: ${colors.base13-rgb};
      --base14: #${colors.base14};
      --base14-rgb: ${colors.base14-rgb};
      --base15: #${colors.base15};
      --base15-rgb: ${colors.base15-rgb};
      --base16: #${colors.base16};
      --base16-rgb: ${colors.base16-rgb};
      --base17: #${colors.base17};
      --base17-rgb: ${colors.base17-rgb};
    }
  '';
in
sensibleLib.sensibleConfig {
  condition = config.sensible.eww.enable;
  assertions = [
    {
      assertion = config.stylix.enable or false;
      message = "eWW module requires stylix to be enabled for color theming";
    }
  ];
  home = {
    packages = with pkgs; [
      eww
      jq
    ];
    xdg.configFile."eww/colors.scss".text = colorsScss;
    xdg.configFile."eww/eww.scss".source = ./bar/eww.scss;
    xdg.configFile."eww/eww.yuck".source = ./bar/eww.yuck;
  };
}
