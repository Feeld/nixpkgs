{ stdenv, fetchurl, pkgconfig, intltool, itstool, glib, dbus-glib, libwnck3, librsvg, libxml2, gnome3, gtk3, mate, hicolor-icon-theme, gobject-introspection, wrapGAppsHook }:

stdenv.mkDerivation rec {
  name = "mate-panel-${version}";
  version = "1.20.4";

  src = fetchurl {
    url = "http://pub.mate-desktop.org/releases/${mate.getRelease version}/${name}.tar.xz";
    sha256 = "02pdrwgl3plgv6l6nc45nsnmjppkxs4ybggwibd6mm777i9nb44d";
  };

  nativeBuildInputs = [
    gobject-introspection
    intltool
    itstool
    pkgconfig
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    dbus-glib
    libwnck3
    librsvg
    libxml2
    gtk3
    gnome3.dconf
    mate.libmateweather
    mate.mate-desktop
    mate.mate-menus
    hicolor-icon-theme
  ];

  NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  makeFlags = [
    "INTROSPECTION_GIRDIR=$(out)/share/gir-1.0/"
    "INTROSPECTION_TYPELIBDIR=$(out)/lib/girepository-1.0"
  ];

  meta = with stdenv.lib; {
    description = "The MATE panel";
    homepage = https://github.com/mate-desktop/mate-panel;
    license = with licenses; [ gpl2 lgpl2 ];
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo ];
  };
}
