{
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation rec {
  name = "vimix-hyprcursor";
  version = "c2314d02e9dfe592c4c1281bbf2c8d5873fb03e9";

  src = fetchFromGitHub {
    repo = "vimix-hyprcursor";
    owner = "BlackFuffey";
    rev = version;
    sha256 = "sha256-j7towY9u6AIoKqsq/X6BIssrfpY+lhAibBvIUcjc6dk=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r $src/themes/* $out/share/icons
  '';
}
