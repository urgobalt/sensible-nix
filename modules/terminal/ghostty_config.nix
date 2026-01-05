{color}:
/*
ini
*/
''
  # General settings
  title = Ghostty
  class = ghostty
  confirm-close-surface = false

  font-size = 10
  font-family = SauceCodePro NFP
  font-style = Medium

  window-padding-x = 20
  window-padding-y = 10
  window-decoration = none

  # Base colors
  background = ${color.background}
  foreground = ${color.text}
  cursor-color = ${color.gray07}

  palette =  0=${color.black}
  palette =  1=${color.red}
  palette =  2=${color.green}
  palette =  3=${color.yellow}
  palette =  4=${color.blue}
  palette =  5=${color.magenta}
  palette =  6=${color.cyan}
  palette =  7=${color.white}
  palette =  8=${color.black}
  palette =  9=${color.bright_red}
  palette = 10=${color.bright_green}
  palette = 11=${color.bright_yellow}
  palette = 12=${color.bright_blue}
  palette = 13=${color.bright_magenta}
  palette = 14=${color.bright_cyan}
  palette = 15=${color.bright_white}

  # Generic color settings
  minimum-contrast = 1
  background-opacity = 0.95
  alpha-blending = native

  # Keybinds
  keybind = ctrl+shift+d=new_window
''
