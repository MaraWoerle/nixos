{ stdenvNoCC
, fetchFromGitHub
, gtk3
}:

stdenvNoCC.mkDerivation rec {
  pname = "Vivid-Dark-Icons";
  version = "1.1";
  dontBuild = true;

  nativeBuildInputs = [ gtk3 ];

  src = fetchFromGitHub {
    owner = "MaraWoerle";
    repo = "Vivid-Plasma-Themes";
    rev = "v${version}";
    sha256 = "sha256-JmIpex0IRVKCDwLn5YDcoTJ/kwJvq7aHkbzppbt50D0=";
  };

  installPhase = ''
    mkdir -p $out/share/icons
    cp -aR $src/Vivid\ Icons\ Themes/Vivid-Dark-Icons $out/share/icons
    gtk-update-icon-cache $out/share/icons/Vivid-Dark-Icons
  '';

  dontDropIconThemeCache = true;
}
