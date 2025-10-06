{
  config,
  lib,
}:
/*
bash
*/
''
  ${
    if config.sensible.sysinfo.package != null
    then
      /*
      bash
      */
      ''
        function clear {
          builtin clear
          if (( $(tput cols) >= 80 )); then
            ${lib.getExe config.sensible.sysinfo.package};
          fi
        }''
    else ""
  }

  ${
    if config.sensible.sysinfo.package != null
    then lib.getExe config.sensible.sysinfo.package
    else ""
  }
''
