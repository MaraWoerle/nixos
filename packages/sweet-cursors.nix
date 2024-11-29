{ stdenvNoCC
, fetchFromGitHub
, gtk3
}:

stdenvNoCC.mkDerivation rec {
  pname = "Vivid-Dark-Icons";
  version = "5.1";
  dontBuild = true;

  nativeBuildInputs = [ gtk3 ];

  src = fetchFromGitHub {
    owner = "MaraWoerle";
    repo = "Sweet";
    rev = "v${version}";
    sha256 = "sha256-jYYN2c8FlhL0+Pb2l3LlsEqkzdyJG7zopNKl1tQsQus=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -R $src/kde/cursors/Sweet-cursors $out/share/icons
  '';
}
