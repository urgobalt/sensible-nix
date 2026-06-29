{
  fetchFromGitHub,
  pkgs,
  libdrm,
  tomlplusplus,
  pixman,
  hyprland,
  hyprutils,
  wayland-protocols,
  wayland-utils,
  wayland,
  libxkbcommon,
  libinput,
  libGL,
  hyprlang,
  hyprland-protocols,
  cairo,
  aquamarine,
  hyprgraphics,
}:
pkgs.unstable.rustPlatform.buildRustPackage rec {
  pname = "hyprkool";
  version = "v0.9.3";

  src = fetchFromGitHub {
    owner = "barbariand";
    repo = "hyprspree";
    rev = version;
    sha256 = "sha256-mMsfeTJAM+njwCWArtzay/YuqnnT4CussHvTC8kdf0Y=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";

    outputHashes = {
      "hyprland-0.4.0-beta.3" = "sha256-DU+WQaEUg8QdIK4x9Zr55whuk8a4UPPHwGYwwZn7gyg=";
    };
  };
  buildInputs = [
    libdrm
    tomlplusplus
    pixman
    hyprland
    hyprutils
    wayland-protocols
    hyprgraphics.dev
    wayland-utils
    wayland
    libinput
    libxkbcommon
    libGL
    hyprlang
    hyprland-protocols
    cairo
    aquamarine
  ];
  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
  ];
  dontUseMesonConfigure = true;
  dontUseCmakeConfigure = true;
  buildPhase = ''
    cargo build --release
    make plugin
    mv ./plugin/build/lib${pname}.so .
  '';
  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    mv ./lib${pname}.so $out/lib/lib${pname}.so
    mv ./target/release/${pname} $out/bin/${pname}
  '';
}

