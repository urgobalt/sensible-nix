{color}:
/*
css
*/
''
  * {
    border: none;
    border-radius: 0;
    font-family: SauceCodePro Nerd Font;
    font-size: 14px;
  }

  window#waybar {
    background: transparent;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #window {
    padding: 5px 16px;
    margin-right: 20px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  window#waybar.empty #window {
    background: transparent;
    padding: 0px;
    margin: 0px;
  }

  #tray {
    padding: 5px 16px;
    margin-right: 20px;
    border-radius: 5px;
    transition: width 0.1s ease-in-out;
    color: ${color.text};
    background: ${color.background};
  }

  #custom-nix-packages {
    padding: 5px 8px 5px 16px;
    border-radius: 5px 0px 0px 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #custom-nix-store {
    padding: 5px 16px 5px 8px;
    border-radius: 0px 5px 5px 0px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #disk {
    padding: 5px 16px;
    margin-left: 20px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #memory {
    padding: 5px 16px;
    border-radius: 5px;
    margin-left: 20px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #cpu {
    padding: 5px 16px;
    border-radius: 5px;
    margin-left: 20px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #clock {
    padding: 5px 16px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #network {
    padding: 5px 16px;
    margin-right: 20px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #bluetooth {
    padding: 5px 16px;
    margin-right: 20px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #custom-volume {
    padding: 5px 16px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }

  #battery {
    padding: 5px 16px;
    margin-left: 20px;
    border-radius: 5px;
    transition: none;
    color: ${color.text};
    background: ${color.background};
  }
''
