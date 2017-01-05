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
  for F in account_bank_statement_import_camt account_bank_statement_import_mt940_base account_bank_statement_import_mt940_nl_ing account_bank_statement_import_mt940_nl_rabo account_bank_statement_import_qif account_bank_statement_import_save_file base_bank_account_number_unique; do
    elog "cp -Rp ${S}/${F} ${D}$(python_get_sitedir)"
    cp -Rp "${S}/${F}" "${D}$(python_get_sitedir)" || die "cp -Rp ${S}/${F} ${D}$(python_get_sitedir)"
  done

    elog "cp -Rp ${S}/setup ${D}$(python_get_sitedir)/${PN}"
    cp -Rp "${S}/setup" "${D}$(python_get_sitedir)/${PN}"
}
