# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utility to modify HCI/SCI controls on Toshiba Laptops"
HOMEPAGE="http://www.schwieters.org/toshset"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/t/toshset/toshset_${PV}.orig.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/pciutils"
RDEPEND="${DEPEND}"
BDEPEND=""

#RESTRICT=mirror
#
#src_unpack() {
#	unpack ${A}
#	epatch toshset_${PV}-2ubuntu1.diff
#	sed -i 's/CFLAGS = -march=i486 \(-Wall @OS_CFLAGS@ @DEBUGFLAGS@\)/CFLAGS := \1 ${CFLAGS}/' ${S}/Makefile.in || die "sed failed"
#}
#
#src_install() {
#	make DESTDIR=${D} install || die
#}
