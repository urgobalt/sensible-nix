{
  config,
  lib,
  ...
}: let
  cfg = config.modules.fish;
in {
  options.modules.fish = {enable = lib.mkEnableOption "fish";};

  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        rm = "trash put";
        ls = "eza";
      };

      shellAbbrs = {
        nvim-dev = "NVIM_APPNAME=nvim-dev nvim";
        ll = "ls -ahl";
        lt = "ls -hlTL 5";
        speedtest = "speedtest-rs";
        st = "speedtest-rs";
        printpath = "printf %s\\n $PATH | column";
        systempath = "printf %s\\n $PATH | grep -v /mnt | column";
      };

      shellInit = lib.strings.concatStrings [
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


          fish_config theme choose Nord
        ''
        (lib.strings.optionalString
          config.modules.fastfetch.enable
          ''
            function clear
              command clear
              if test (tput cols) -ge 80
                fastfetch
              end
            end
          '')
      ];

      interactiveShellInit = ''
        clear
        set fish_greeting # Disable greeting
      '';
    };
  };
}
