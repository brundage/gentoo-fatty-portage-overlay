# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
inherit eutils python-utils-r1 git-r3
EPYTHON="python"
PYTHON=$EPYTHON
DESCRIPTION="Odoo Bank Import Addons"
HOMEPAGE="https://github.com/OCA/bank-statement-import"
EGIT_CHECKOUT_DIR="${S}"
EGIT_REPO_URI="https://github.com/OCA/bank-statement-import.git"
LICENSE="AGPL"
KEYWORDS="amd64 x86"
DEPEND="app-office/odoo"

src_install() {
  mkdir -p "${D}/$(python_get_sitedir)/${PN}/"
  elog "rsync -aHSv ${S}/*  ${D}/$(python_get_sitedir)/${PN}/"
  rsync -aHSv "${S}/*"  "${D}/$(python_get_sitedir)/${PN}/" || die "rsync -aHSv ${S}/*  ${D}/$(python_get_sitedir)/${PN}/"
}
