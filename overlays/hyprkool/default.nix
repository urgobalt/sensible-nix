{prev}: {
  bin = prev.callPackage ./bin.nix {};
  plugin = prev.callPackage ./plugin.nix {};
}
