# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
SLOT="0"

inherit eutils python-utils-r1 git-r3
EPYTHON="python"
PYTHON=$EPYTHON

DESCRIPTION="Odoo Bank Import Addons"

HOMEPAGE="https://github.com/OCA/bank-statement-import"

EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"
EGIT_REPO_URI="https://github.com/OCA/bank-statement-import.git"
D="$(python_get_sitedir)/${PN}"

LICENSE="AGPL"

KEYWORDS="amd64 x86"

DEPEND="app-office/odoo"
