# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"

S="${WORKDIR}"

DESCRIPTION="IP over ICMP"

HOMEPAGE="http://code.gerade.org/hans/"

SRC_URI="https://github.com/friedrich/hans/archive/v${PV}.zip"

LICENSE="GPL"

KEYWORDS="amd64 x86"

src_compile() {
  cd "${WORKDIR}/${P}"
  emake
}

src_install() {
  cp "${WORKDIR}/${P}/hans" "${D}" || die "Install failed!"
}
