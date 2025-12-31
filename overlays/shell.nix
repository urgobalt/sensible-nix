{
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "shell";
  version = "7a197ad6e2e3cc51bc2923ce7494c8c23f6e3dd6";

  src = fetchFromGitHub {
    owner = "prefix-dev";
    repo = "shell";
    rev = version;
    hash = "sha256-ylDt4CDUzIrbVTFP6snmDQzL7KdKZGi6/Q2I9EfRMhw=";
  };

  cargoHash = "sha256-ml3kuelaKqTh7Kqm9BllyPAMMp4G1GG3fDiLc5d1rFM=";
  checkFlags = ["--skip=shell::commands::cd::test::test_directory_navigation"];

  meta.mainProgram = pname;
}
