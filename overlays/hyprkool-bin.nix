{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "3f56d829b44218d70867886b91d9f697d8ad9f68";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-HHmJey9l4+BW+5PYMLfeqcHwtIZcJ8ZI42ARgRRNC+E=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "hyprland-0.4.0-alpha.2" = "sha256-7GRj0vxsQ4ORp0hSBAorjFYvWDy+edGU2IL3DhFDLvQ=";
    };
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
}
