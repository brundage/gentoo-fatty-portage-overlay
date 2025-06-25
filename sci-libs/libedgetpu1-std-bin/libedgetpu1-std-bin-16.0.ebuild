# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# to find package names
# wget  https://packages.cloud.google.com/apt/dists/coral-edgetpu-stable/main/binary-amd64/Packages
# ebuild libedgetpu1-std-bin-16.0.ebuild manifest

EAPI=8

DESCRIPTION="Google Edge TPU runtime (binary-only Debian package)"
HOMEPAGE="https://coral.ai/software/"
SRC_URI="https://packages.cloud.google.com/apt/pool/coral-edgetpu-stable/libedgetpu1-std_${PV}_amd64_2c0876273727b93e13001ceeed80bf5b.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror strip"

DEPEND="app-arch/dpkg"
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
    dpkg -x "${DISTDIR}/${A}" "${S}" || die "dpkg extraction failed"
}

src_install() {
    # Install all files to root filesystem as they are in the deb package
    cp -a "${S}"/usr "${D}" || die "install failed"
}


