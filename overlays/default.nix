_final: prev: {
  vmware = prev.callPackage ./vmware.nix {
    final = _final;
    prev = prev;
  };
  apple-color-emoji = prev.callPackage ./apple-color-emoji.nix {};
  hyprspace = prev.callPackage ./hyprspace.nix {};
  hyprkool = prev.callPackage ./hyprkool.nix {};
  zen-browser = prev.callPackage ./zen-browser {};
  vimix-hyprcursor = prev.callPackage ./vimix-hyprcursor.nix {};
  sddm-glassy = prev.callPackage ./sddm-glassy {};
  regreet = prev.callPackage ./regreet.nix {};
  hypr-zoom = prev.callPackage ./hypr-zoom.nix {};
}
