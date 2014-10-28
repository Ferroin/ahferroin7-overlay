# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools

DESCRIPTION=""
HOMEPAGE="http://www.nongnu.org/oath-toolkit/index.html"
SRC_URI="http://download.savannah.gnu.org/releases/oath-toolkit/oath-toolkit-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm ppc sparc mips alpha hppa ia64 m64k sh -x86-fbsd -amd64-fbsd -sparc-fbsd"
IUSE="+pam +pskc"

DEPEND="
>=dev-libs/libxml2-2.0.0
dev-util/pkgconfig
pskc? ( dev-libs/xmlsec )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_enable pam) \
		$(use_enable pskc)
}
