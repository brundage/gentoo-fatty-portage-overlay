# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"

S="${WORKDIR}"

DESCRIPTION="Slack messaging application for teams"

HOMEPAGE="https://slack.com/"

# https://downloads.slack-edge.com/linux_releases/slack-desktop-2.0.3-i386.deb
SRC_URI="x86? ( https://downloads.slack-edge.com/linux_releases/${P}-i386.deb )
       amd64? ( https://downloads.slack-edge.com/linux_releases/${P}-amd64.deb )"

LICENSE="Slack"

KEYWORDS="amd64 x86"

DEPEND="app-arch/tar
	sys-devel/binutils"

RDEPEND=">=gnome-base/gconf-2
         >=x11-libs/gtk+-2
         virtual/libudev
"

ARBALL="${DISTDIR}/${A}"
DATA="${WORKDIR}/data.tar.xz"


src_compile() {
	true
}


src_configure() {
	true
}


src_install() {
	if [ -r ${DATA} ]; then
		tar xJf ${DATA} -C "${D}"
    else
		die "data file not found at ${DATA}"
    fi
}


src_prepare() {
	true
}


src_unpack() {
	[[ -f "${ARBALL}" ]] && ar x "${ARBALL}"
}
