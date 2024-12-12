{
  fetchFromGitHub,
  pkgs,
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "1263ad8800213b7ac5088a1a1ad3b309ddd0bd92";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-II9j5IplV6tWg7AKsKIGkFSeDby+AJgB+nNHv3cU16k=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "hyprland-0.4.0-alpha.2" = "sha256-7GRj0vxsQ4ORp0hSBAorjFYvWDy+edGU2IL3DhFDLvQ=";
    };
  };
  buildInputs = [
  ];
  nativeBuildInputs = with pkgs; [
    pkg-config
    hyprland
  ];
  dontUseMesonConfigure = true;
  dontUseCmakeConfigure = true;
  buildPhase = ''
    make plugin
    mv ./plugin/build/lib${pname}.so .
  '';
  installPhase = ''
    mkdir -p $out/lib
    mv ./lib${pname}.so $out/lib/lib${pname}.so
  '';
}
