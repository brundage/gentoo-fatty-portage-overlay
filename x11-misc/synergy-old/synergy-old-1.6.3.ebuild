# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic gnome2-utils cmake-utils

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers"
HOMEPAGE="http://synergy-project.org/ https://github.com/synergy/synergy"
SRC_URI="
	https://github.com/synergy/synergy/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://dev.gentoo.org/~jer/${PN}.png
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="test"

COMMON_DEPEND="
	>=dev-libs/crypto++-5.6.2
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXtst
"
DEPEND="
	${COMMON_DEPEND}
	test? ( >=dev-cpp/gmock-1.6.0 )
	x11-proto/kbproto
	x11-proto/randrproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
"
RDEPEND="
	${COMMON_DEPEND}
"

PATCHES=(
	"${FILESDIR}/${PN}-1.4.16_p1969-pthread.patch"
	"${FILESDIR}/${PN}-1.4.17_p2055-cryptopp.patch"
	"${FILESDIR}/${PN}-1.4.17_p2055-test.patch"
	"${FILESDIR}/${PN}-1.4.17_p2055-gentoo.patch"
	"${FILESDIR}/${PN}-1.4.17_p2055-CSocketMultiplexer.patch"
)

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=$(cmake-utils_use_with test GENTOO_TEST)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	local exe fail
	for exe in bin/integtests bin/unittests; do
		${exe} || fail+=" ${exe}"
	done
	[[ ${fail} ]] && ewarn "${fail} failed"
}

src_install () {
	dobin bin/${PN}{c,s}

	insinto /etc
	newins doc/synergy.conf.example synergy.conf

	newman doc/${PN}c.man ${PN}c.1
	newman doc/${PN}s.man ${PN}s.1

	dodoc README doc/synergy.conf.example* ChangeLog
}
