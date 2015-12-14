EAPI="5"

DESCRIPTION="Netrek COW"
HOMEPAGE="https://www.netrek.org/"
SRC_URI="http://www.netrek.org/files/COW/${PN}-${PV}.tar.gz"

KEYWORDS="~amd64 ~x86"

SLOT="0"

DEPEND="media-libs/sdl-mixer
  media-libs/imlib2
  dev-libs/gmp
  virtual/libc
  x11-libs/libX11
  x11-libs/libXpm
  x11-libs/libXxf86vm
"
