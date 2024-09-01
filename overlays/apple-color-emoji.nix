{lib}: let
  pname = "apple-color-emoji";
  version = "f04a257390403d14ecb4d43191e2c1406d764e55";
in
  builtins.fetchurl {
    name = "${pname}-${version}";
    url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
    sha256 = "sha256:1wahjmbfm1xgm58madvl21451a04gxham5vz67gqz1cvpi0cjva8";
  }
