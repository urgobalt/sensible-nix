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
  version = "0.9.2";

  src = fetchFromGitHub {
    owner = "thrombe";
    repo = "hyprkool";
    rev = version;
    sha256 = "sha256-/u8YzjgiagERZhFa9eDvR7Z61913K/RZnpt/r3/4OfI=";
  };
  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    outputHashes = {
      "hyprland-0.4.0-beta.2" = "sha256-Vvpb5BzzTjol6UmJjkqymLlARr4gRJaS5k4aONNlcsk=";
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
    # xorg.libXcursor
    # xorg.libxcb
    # xorg.libXdmcp
    # xorg.xcbutilerrors
    # xorg.xcbutilrenderutil
    # xorg.xcbutilwm
    # xwayland
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
