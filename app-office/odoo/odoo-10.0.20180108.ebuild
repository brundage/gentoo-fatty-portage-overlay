# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/odoo/odoo-7.0.20130219-r5.ebuild,v 1.2 2013/03/11 03:10:59 patrick Exp $

# taken from http://gpo.zugaina.org/app-office/odoo

EAPI="6"

LICENSE="AGPLv3"

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

#inherit eutils distutils user versionator
inherit distutils-r1 user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="https://www.odoo.com/"
SRC_URI="https://nightly.odoo.com/10.0/nightly/src/${PN}_${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+postgres ssl"

RDEPEND="postgres? ( dev-db/postgresql )
  net-libs/nodejs
"

DEPEND="${CDEPEND}
  dev-python/setuptools
"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

S="${WORKDIR}/${P/odoo-10.0./odoo-10.0.post}"

pkg_setup() {
#  python_set_active_version 2
  default_pkg_setup

  enewgroup ${ODOO_GROUP}
  enewuser ${ODOO_USER} -1 -1 -1 ${ODOO_GROUP}
}


#src_install() {
#  default_src_install

  # For later init.d and conf.d crap
  #newinitd "${FILESDIR}/odoo-initd-${BASE_VERSION}" "${PN}"
  #newconfd "${FILESDIR}/odoo-confd-${BASE_VERSION}" "${PN}"
  #dodir /etc/odoo
  #insinto /etc/odoo
  #newins "${FILESDIR}"/odoo-cfg-${BASE_VERSION} odoo.cfg || die

#  keepdir /var/log/odoo
#  insinto /etc/logrotate.d
#  newins "${FILESDIR}"/odoo.logrotate odoo || die

#}

pkg_preinst() {
#  fowners ${ODOO_USER}:${ODOO_GROUP} /var/log/odoo
#  fowners -R ${ODOO_USER}:${ODOO_GROUP} "$(python_get_sitedir)/${PN}/addons/"
  use postgres || sed -i '6,8d' "${D}/etc/init.d/odoo" || die "sed failed"
}

pkg_postinst() {
#  chown ${ODOO_USER}:${ODOO_GROUP} /var/log/odoo
#  chown -R ${ODOO_USER}:${ODOO_GROUP} "$(python_get_sitedir)/${PN}/addons/"

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

psqlquery() {
  psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
  einfo "In the following, the 'postgres' user will be used."
  if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${ODOO_USER}'" | grep -q ${ODOO_USER}; then
    ebegin "Creating database user ${ODOO_USER}"
    createuser --username=postgres --createdb --no-adduser ${ODOO_USER}
    eend $? || die "Failed to create database user"
  fi
}
