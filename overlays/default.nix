_final: prev: {
  apple-color-emoji = prev.callPackage ./apple-color-emoji.nix {};
  hyprspace = prev.callPackage ./hyprspace.nix {};
  hyprkool = prev.symlinkJoin {
    name = "hyprkool";
    paths = [(prev.callPackage ./hyprkool-bin.nix {}) (prev.callPackage ./hyprkool-plugin.nix {})];
  };
}
