{
  fetchFromGitHub,
  pkgs,
}:

pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "0.9.3";

  src = fetchFromGitHub {
    owner = "barbariand";
    repo = "hyprspree";
    rev = "v${version}";
    hash = "sha256-mMsfeTJAM+njwCWArtzay/YuqnnT4CussHvTC8kdf0Y=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "hyprland-0.4.0-beta.3" = "sha256-DU+WQaEUg8QdIK4x9Zr55whuk8a4UPPHwGYwwZn7gyg=";
    };
  };
}
