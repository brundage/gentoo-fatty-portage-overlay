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
  dev-python/Babel
  dev-python/decorator
  dev-python/docutils
  dev-python/ebaysdk
  dev-python/feedparser
  dev-python/gevent
  dev-python/greenlet
  dev-python/html2text
  >=dev-python/jinja-2
  dev-python/lxml
  dev-python/mako
  dev-python/markupsafe
  dev-python/mock
  dev-python/num2words
  dev-python/ofxparse
  dev-python/passlib
  dev-python/pillow
  dev-python/psutil
  >=dev-python/psycopg-2
  dev-python/pydot
  dev-python/pyldap
  dev-python/pyparsing
  dev-python/PyPDF2
  dev-python/pyserial
  dev-python/python-dateutil
  dev-python/pytz
  dev-python/pyusb
  dev-python/pyyaml
  dev-python/qrcode
  dev-python/reportlab
  dev-python/requests
  dev-python/six
  dev-python/suds
  dev-python/vatnumber
  dev-python/vobject
  dev-python/werkzeug
  dev-python/xlsxwriter
  dev-python/xlwt
  dev-python/xlrd
  net-libs/nodejs
"

DEPEND="${CDEPEND}
  dev-python/setuptools
"

ODOO_USER="odoo"
ODOO_GROUP="odoo"

S="${WORKDIR}/${P/odoo-11.0./odoo-11.0.post}"
