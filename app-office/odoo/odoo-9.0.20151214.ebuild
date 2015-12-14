# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/odoo/odoo-7.0.20130219-r5.ebuild,v 1.2 2013/03/11 03:10:59 patrick Exp $

# taken from http://gpo.zugaina.org/app-office/odoo

EAPI="3"
PYTHON_DEPEND="2"

LICENSE="AGPLv3"

inherit eutils distutils user versionator

MY_PV="9.0c.$(get_version_component_range 3)"

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="https://www.odoo.com/"
SRC_URI="https://nightly.odoo.com/9.0/nightly/src/${PN}_${MY_PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+postgres ldap ssl"

CDEPEND="postgres? ( dev-db/postgresql )
  dev-python/Babel
  dev-python/jinja
  dev-python/mako
  dev-python/markupsafe
  dev-python/pillow
  dev-python/pychart
  dev-python/pyyaml
  dev-python/werkzeug
  dev-python/docutils
  dev-python/feedparser
  dev-python/gdata
  dev-python/gevent
  dev-python/greenlet
  dev-python/jcconv
  dev-python/lxml
  dev-python/mock
  dev-python/ofxparse
  dev-python/passlib
  dev-python/psutil
  dev-python/psycogreen
  dev-python/psycopg:2
  dev-python/pyPdf
  dev-python/pyparsing
  dev-python/pyserial
  dev-python/python-dateutil
  ldap? ( dev-python/python-ldap )
  dev-python/python-openid
  dev-python/pytz
  dev-python/pyusb
  dev-python/qrcode
  dev-python/reportlab
  dev-python/requests
  dev-python/six
  ssl? ( dev-python/pyopenssl )
  dev-python/suds
  dev-python/vatnumber
  dev-python/vobject
  dev-python/wsgiref
  net-libs/nodejs
  media-gfx/pydot
  dev-python/xlwt
"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

S="${WORKDIR}/${P/9.0./9.0-}"

pkg_setup() {
  python_set_active_version 2
  python_pkg_setup
}

src_unpack() {
  unpack ${A}
}

src_install() {
  distutils_src_install

#  newinitd "${FILESDIR}/odoo-initd-${BASE_VERSION}" "${PN}"
#  newconfd "${FILESDIR}/odoo-confd-${BASE_VERSION}" "${PN}"
  keepdir /var/log/odoo

#  insinto /etc/logrotate.d
#  newins "${FILESDIR}"/odoo.logrotate odoo || die
#  dodir /etc/odoo
#  insinto /etc/odoo
#  newins "${FILESDIR}"/odoo-cfg-${BASE_VERSION} odoo.cfg || die
}

pkg_preinst() {
  enewgroup ${ODOO_GROUP}
  enewuser ${ODOO_USER} -1 -1 -1 ${ODOO_GROUP}

  fowners ${ODOO_USER}:${ODOO_GROUP} /var/log/odoo
  fowners -R ${ODOO_USER}:${ODOO_GROUP} "$(python_get_sitedir)/${PN}/addons/"

  use postgres || sed -i '6,8d' "${D}/etc/init.d/odoo" || die "sed failed"
}

pkg_postinst() {
  chown ${ODOO_USER}:${ODOO_GROUP} /var/log/odoo
  chown -R ${ODOO_USER}:${ODOO_GROUP} "$(python_get_sitedir)/${PN}/addons/"

  elog "In order to create the database user, run:"
  elog " emerge --config =${CATEGORY}/${PF}"
  elog "Be sure the database is started before"
  elog
  elog "Use odoo web interface in order to create a "
  elog "database for your company."
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
