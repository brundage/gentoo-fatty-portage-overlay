# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"

MY_P=${P/beersmith/BeerSmith}

S="${WORKDIR}"

DESCRIPTION="BeerSmith home brewing software"

HOMEPAGE="http://beersmith.com/"

SRC_URI="amd64? ( https://s3.amazonaws.com/beersmith2-3/${MY_P}_amd64.deb )"

LICENSE="BeerSmith2"

KEYWORDS="amd64 x86"

DEPEND="app-arch/tar
	sys-devel/binutils"

RDEPEND="media-libs/libpng:1.2
	virtual/jpeg"

ARBALL="${DISTDIR}/${A}"
CONTROL_TARBALL="${WORKDIR}/control.tar.gz"
POSTINST="${WORKDIR}/postinst"
POSTRM="${WORKDIR}/postrm"
POSTRM_PRESERVED="/usr/share/BeerSmith2/${MY_P}-postrm"
PREINST="${WORKDIR}/preinst"
PRERM="${WORKDIR}/prerm"
PRERM_PRESERVED="/usr/share/BeerSmith2/${MY_P}-prerm"
DATA="${WORKDIR}/data.tar.xz"


pkg_postinst() {
	[[ -x ${POSTINST} ]] && ${POSTINST}
}


pkg_postrm() {
	[[ -x "${ROOT}/${POSTRM_PRESERVED}" ]] && ${ROOT}/${POSTRM_PRESERVED}
}


pkg_preinst() {
	[[ -x ${PREINST} ]] && ${PREINST}
}


pkg_prerm() {
	[[ -x "${ROOT}/${PRERM_PRESERVED}" ]] && ${ROOT}/${PRERM_PRESERVED}
}


preserve_rm_scripts() {
	[[ -f "${POSTRM}" ]] && cp --preserve=mode "${POSTRM}" "${D}/${POSTRM_PRESERVED}"
	[[ -f "${PRERM}" ]] && cp --preserve=mode "${PRERM}" "${D}/${PRERM_PRESERVED}"
}


src_compile() {
	true
}


src_configure() {
	true
}


src_install() {
	if [ -r ${DATA} ]; then
		tar xf ${DATA} -C "${D}"
		preserve_rm_scripts
    else
		die "data file not found at ${DATA}"
    fi
}


src_prepare() {
	true
}


src_unpack() {
	[[ -f "${ARBALL}" ]] && ar x "${ARBALL}"
	[[ -f "${CONTROL_TARBALL}" ]] && tar xpzf "${CONTROL_TARBALL}"
}
