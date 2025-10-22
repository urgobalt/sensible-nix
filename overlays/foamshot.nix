{
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cairo,
  libxkbcommon,
}:
rustPlatform.buildRustPackage rec {
  pname = "foamshot";
  version = "0.2.7";

  src = fetchFromGitHub {
    owner = "Thirdwinter";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-K4AQIewC9fNXfyRPlZUUSWrZCbHgWhJHq3k5VkoMixU=";
  };

  nativeBuildInputs = [pkg-config];
  buildInputs = [cairo libxkbcommon];

  cargoHash = "sha256-BL8n82tKuE2r/gCuw9BYjt9h8ja2Qw73Snm+oI6zZe8=";
}
