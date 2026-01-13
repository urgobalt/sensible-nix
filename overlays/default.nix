_final: prev: {
  apple-color-emoji = prev.callPackage ./apple-color-emoji.nix {};
  hyprspace = prev.callPackage ./hyprspace.nix {};
  hyprkool = prev.callPackage ./hyprkool.nix {};
  zen-browser = prev.callPackage ./zen-browser {};
  #vimix-hyprcursor = prev.callPackage ./vimix-hyprcursor.nix {};
  sddm-glassy = prev.callPackage ./sddm-glassy {};
  regreet = prev.callPackage ./regreet.nix {};
  hypr-zoom = prev.callPackage ./hypr-zoom.nix {};
  # BUG: The following package works when directly calling from devshell but
  # results in an error
  # error: function 'anonymous lambda' called with unexpected argument 'nativeBuildInputs'
  # shell = prev.callPackage ./shell.nix {};
}
