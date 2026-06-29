{config}: let
  c = config.lib.stylix.colors;
in
  ''
    * {
      border: none;
      border-radius: 0;
      font-family: SauceCodePro Nerd Font;
      font-size: 14px;
    }

    window#waybar { background: transparent; }

    window#waybar.hidden { opacity: 0.2; }

    #window {
      padding: 5px 16px;
      margin-right: 20px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
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
      color: ${c.base05};
      background: ${c.base01};
    }

    #custom-nix-packages {
      padding: 5px 8px 5px 16px;
      border-radius: 5px 0px 0px 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #custom-nix-store {
      padding: 5px 16px 5px 8px;
      border-radius: 0px 5px 5px 0px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #disk {
      padding: 5px 16px;
      margin-left: 20px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #memory {
      padding: 5px 16px;
      border-radius: 5px;
      margin-left: 20px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #cpu {
      padding: 5px 16px;
      border-radius: 5px;
      margin-left: 20px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #clock {
      padding: 5px 16px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #network {
      padding: 5px 16px;
      margin-right: 20px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #bluetooth {
      padding: 5px 16px;
      margin-right: 20px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #custom-volume {
      padding: 5px 16px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }

    #battery {
      padding: 5px 16px;
      margin-left: 20px;
      border-radius: 5px;
      transition: none;
      color: ${c.base05};
      background: ${c.base01};
    }
  ''
