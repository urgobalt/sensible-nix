{
  pkgs,
  config,
  lib,
  ...
}: {
  condition = config.sensible.shell.name == "fish";
  system.sensible.shell.package = lib.mkDefault pkgs.fish;
  home.programs.fish =
    {
      enable = true;
      package = config.system.sensible.shell.package;

      shellInit =
        /*
        fish
        */
        ''
          fish_vi_key_bindings

          function storePathForWindowsTerminal --on-variable PWD
            if test -n "$WT_SESSION"
              printf "\e]9;9;%s\e\\" (wslpath -w "$PWD")
            end
          end

          function take
            mkdir -p $argv && cd $argv
          end

          ${
            if config.sensible.sysinfo.name != "none"
            then ''
              function clear
                command clear
                if test (tput cols) -ge 80
                  ${lib.getExe config.sensible.sysinfo.package}
                end
              end''
            else ""
          }

          ${
            if config.sensible.sysinfo.name != "none"
            then lib.getExe config.sensible.sysinfo.package
            else ""
          }
        '';
    }
    // import ./general_shell_options.nix;
  home.home.packages = import ./packages.nix pkgs;
}
