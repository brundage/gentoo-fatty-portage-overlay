# Copyright 2026 Gentoo Authors
# Distributed under the terms of the MIT License

EAPI=8

DESCRIPTION="Root CA certificate for Homeland Lab"
HOMEPAGE="https://wiki.internal/"
# We use a dummy SRC_URI because the file is local
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64"

# This package provides the cert, but needs the system tool to update the store
RDEPEND="app-misc/ca-certificates"

S="${WORKDIR}"

src_install() {
	# Standard Gentoo path for custom CA certs
	insinto /usr/local/share/ca-certificates/homeland
	newins "${FILESDIR}/root_ca.crt" "${PN}.crt"
	insinto /etc/firefox/policies
	newins "${FILESDIR}/policies.json"
}

pkg_postinst() {
	# Automatically update the trust store after installation
	ebegin "Updating system CA certificates"
	/usr/sbin/update-ca-certificates --fresh
	eend $?
}

pkg_postrm() {
	# Clean up the trust store after removal
	ebegin "Updating system CA certificates (removal)"
	/usr/sbin/update-ca-certificates --fresh
	eend $?
}
