# taken from https://gpo.zugaina.org/app-office/odoo
# read this shit too https://wiki.gentoo.org/wiki/Project:Python/Eclasses
# also this https://wiki.gentoo.org/wiki/Project:Python/Python.eclass_conversion
# then maybe this shit https://wiki.gentoo.org/wiki/Project:Python/distutils-r1

EAPI="6"
PYTHON_COMPAT=( python3_{5,6} )  # for distutils

inherit distutils-r1 eutils user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="https://www.odoo.com/"
SRC_URI="https://nightly.odoo.com/11.0/nightly/src/${PN}_${PV}.tar.gz"
LICENSE="AGPLv3"

IUSE="+postgres ssl"

KEYWORDS="~x86 ~amd64"
SLOT="0"

RDEPEND="postgres? ( dev-db/postgresql[server] )
  net-libs/nodejs
"

DEPEND="${CDEPEND}
  dev-python/setuptools
"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

S="${WORKDIR}/${P/odoo-11.0./odoo-11.0.post}"
