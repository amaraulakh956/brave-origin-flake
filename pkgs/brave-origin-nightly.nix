{ lib, stdenv, fetchurl, dpkg, autoPatchelfHook, wrapGAppsHook3
, gtk3, glib, nss, nspr, atk, cups, dbus, expat, libdrm
, libX11, libXcomposite, libXdamage, libXext, libXfixes, libXrandr
, mesa, libxkbcommon, pango, cairo, alsa-lib
, at-spi2-atk, at-spi2-core, qt6 }:

stdenv.mkDerivation rec {
  pname = "brave-origin-nightly";
  version = "1.93.67";

  src = fetchurl {
    url = "https://github.com/brave/brave-browser/releases/download/v${version}/${pname}_${version}_amd64.deb";
    sha256 = "1pnc7rc6k3xi4d55kf0pivwnkviy5vag6s9q6j8wb7ana59avvmf";
  };

  nativeBuildInputs = [ dpkg autoPatchelfHook wrapGAppsHook3 ];

  buildInputs = [
    gtk3 glib nss nspr atk cups dbus expat libdrm
    libX11 libXcomposite libXdamage libXext libXfixes libXrandr
    mesa libxkbcommon pango cairo alsa-lib
    at-spi2-atk at-spi2-core
    qt6.qtbase
    qt6.qtwayland
  ];

  dontWrapQtApps = true;

  autoPatchelfIgnoreMissingDeps = [
    "libQt5Core.so.5"
    "libQt5Gui.so.5"
    "libQt5Widgets.so.5"
  ];

  unpackPhase = ''
    dpkg-deb --fsys-tarfile $src | tar x --no-same-permissions --no-same-owner
  '';

  installPhase = ''
  mkdir -p $out/bin
  mkdir -p $out/opt/brave.com/brave-origin-nightly
  cp -r opt/brave.com/brave-origin-nightly/* $out/opt/brave.com/brave-origin-nightly/
  ln -s $out/opt/brave.com/brave-origin-nightly/brave-origin-nightly $out/bin/brave-origin-nightly
  mkdir -p $out/share
  cp -r usr/share/* $out/share/ 2>/dev/null || true

  # Fix desktop file paths
  substituteInPlace $out/share/applications/brave-origin-nightly.desktop \
    --replace "/usr/bin/brave-origin-nightly" "$out/bin/brave-origin-nightly"
'';

  meta = {
    description = "Brave Origin Nightly - minimalist privacy browser";
    homepage = "https://brave.com/origin";
    license = lib.licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "brave-origin-nightly";
  };
}
