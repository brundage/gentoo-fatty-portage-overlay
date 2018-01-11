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

pkg_preinst() {
  use postgres || sed -i '6,8d' "${D}/etc/init.d/odoo" || die "sed failed"
}


pkg_postinst() {
  elog "In order to create the database user, run:"
  elog " emerge --config =${CATEGORY}/${PF}"
  elog "Be sure the database is started before"
  elog
  elog "Use odoo web interface in order to create a "
  elog "database for your company."
  elog
  elog "You will need to install less and less-pulgin-clean-css"
  elog "  npm install -g less"
  elog "  npm install -g less-plugin-clean-css"
}


pkg_setup() {
  python_setup
  enewgroup ${ODOO_GROUP}
  enewuser ${ODOO_USER} -1 -1 -1 ${ODOO_GROUP}
}


pkg_config() {
  einfo "In the following, the 'postgres' user will be used."
  if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q ${ODOO_USER}; then
    ebegin "Creating database user ${ODOO_USER}"
    /usr/bin/createuser --username=postgres --createdb --no-adduser ${ODOO_USER}
    eend $? || die "Failed to create database user"
  fi
}


psqlquery() {
  /usr/bin/psql -q -At -U postgres -d template1 -c "$@"
}


src_install() {
  dodir "/var/log/odoo"
  fowners ${ODOO_USER}:${ODOO_GROUP} "/var/log/odoo"
  fowners -R ${ODOO_USER}:${ODOO_GROUP} "$(python_get_sitedir)/${PN}/addons/"
  python_install
}
