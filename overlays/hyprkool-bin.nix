{
  lib,
  stdenv,
  fetchFromGitHub,
  pkgs,
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "e0ae6c6b6513eaa70540fea200031743e4b62165";

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
