# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"

S="${WORKDIR}"

DESCRIPTION="Republic Wireless Anywhere"

HOMEPAGE="http://republicwireless.com"

SRC_URI="amd64? ( https://s3.amazonaws.com/files.republicwireless.com/public/apps/anywhere/debian/pool/main/r/republicanywhere/republicanywhere_${PV}_amd64.deb )"

KEYWORDS="amd64"

DEPEND="app-arch/tar
    app-arch/xz-utils
	sys-devel/binutils"

#RDEPEND= A pile of stuff


ARBALL="${DISTDIR}/${A}"
CONTROL_TARBALL="${WORKDIR}/control.tar.gz"
POSTINST="${WORKDIR}/postinst"
POSTRM="${WORKDIR}/postrm"
PREINST="${WORKDIR}/preinst"
PRERM="${WORKDIR}/prerm"
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
