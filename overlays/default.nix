_final: prev: {
  apple-color-emoji = prev.callPackage ./apple-color-emoji.nix {};
  hyprspace = prev.callPackage ./hyprspace.nix {};
  hyprkool-bin = prev.callPackage ./hyprkool-bin.nix {};
  hyprkool-plugin = prev.callPackage ./hyprkool-plugin.nix {};
  zen-browser = prev.callPackage ./zen-browser {};
}
