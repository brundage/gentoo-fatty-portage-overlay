# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Lightweight Ruby version changer"
HOMEPAGE="https://github.com/postmodern/chruby"
#SRC_URI="https://github.com/postmodern/${PN}/releases/download/v${PV}/chruby-0.3.9.tar.gz"
SRC_URI="https://github.com/postmodern/${PN}/releases/download/v${PV}/${P}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"

# chruby only requires a POSIX-compliant shell to run.
RDEPEND="|| ( app-shells/bash app-shells/zsh )"
DEPEND=""
BDEPEND=""

src_prepare() {
	default
	# The default Makefile forces installation to /usr/local. 
	# We override PREFIX to properly map to Gentoo's system-managed /usr.
	sed -i -e "s|PREFIX=\/usr\/local|PREFIX=\/usr|g" Makefile || die "sed failed"
}

src_compile() {
	# No compilation required (scripts and docs only).
	:
}

src_install() {
	# Install directly using chruby's native Makefile layout targets
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	# Gentoo policy expects standard documentation to go to the correct doc dir
	dodoc README.md CHANGELOG.md
}

pkg_postinst() {
	elog "To enable chruby, add the following to your shell profile (~/.bashrc or ~/.zshrc):"
	elog "  source /usr/share/chruby/chruby.sh"
	elog ""
	elog "If you also want auto-switching via .ruby-version files, include:"
	elog "  source /usr/share/chruby/auto.sh"
}
