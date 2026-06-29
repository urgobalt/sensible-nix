 {
   config,
   lib,
   sensibleLib,
   ...
 }:
 sensibleLib.sensibleConfig {
   condition = config.sensible.shell.fish.enable;
   home.programs.fish =
     {
       enable = true;
      package = config.sensible.shell.fish.package;

       shellInit =
         /*
         fish
         */
         ''
           fish_vi_key_bindings

           function take
             mkdir -p $argv && cd $argv
           end

           function sysinfo
             if test (tput cols) -ge 80
               ${lib.getExe <| sensibleLib.getDefaultPackage config.sensible.sysinfo}
             end
           end

           ${
             if config.sensible.sysinfo.default != "none"
             then ''
               function clear
                 command clear
                 sysinfo
               end''
             else ""
           }
         '';
     }
     // import ./general_shell_options.nix;
  # home.home.packages = import ./packages.nix pkgs;
 }
