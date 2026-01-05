{
  shellAliases = {
    rm = "trash put";
    ls = "eza";
  };

  shellAbbrs = {
    nvim-dev = "NVIM_APPNAME=nvim-dev nvim";
    ll = "ls -ahl";
    lt = "ls -hlTL 5";
    printpath = "printf %s\\n $PATH | column";
    systempath = "printf %s\\n $PATH | grep -v /mnt | column";
  };
}
