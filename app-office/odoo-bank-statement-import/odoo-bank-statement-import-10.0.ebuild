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

ADDONS="${D}/$(python_get_sitedir)/odoo/addons"

# /usr/lib64/python2.7/site-packages/odoo/addons/
src_install() {
  mkdir -p "${ADDONS}"
  for F in account_bank_statement_import_qif base_bank_account_number_unique account_bank_statement_import_ofx; do
    elog "cp -Rp ${S}/${F} ${ADDONS}"
    cp -Rp "${S}/${F}" "${ADDONS}" || die "cp -Rp ${S}/${F} ${ADDONS}"
  done

  mkdir -p "${ADDONS}/${PN}"
  elog "cp -Rp ${S}/setup${ADDONS}/${PN}"
  cp -Rp "${S}/setup" "${ADDONS}/${PN}"
}
