# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools git-r3 systemd versionator

DESCRIPTION="The USBGuard software framework helps to protect your computer against BadUSB."
HOMEPAGE="https://github.com/dkopecek/usbguard"
MY_AUTHOR="dkopecek"
EGIT_REPO_URI="https://github.com/${MY_AUTHOR}/${PN}.git"

if [[ ${PV} == "9999" ]] ; then
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	MAJOR_V="$(get_version_component_range 1 ${PV})"
	MINOR_V="$(get_version_component_range 2 ${PV})"
	PATCH_V="$(get_version_component_range 3 ${PV})"
	EGIT_COMMIT="v${MAJOR_V}.${MINOR_V}${PATCH_V}"
	KEYWORDS="~x86 ~amd64"
fi


LICENSE="GPL-2"
SLOT="0"
IUSE="systemd qt4"

DEPEND="sys-cluster/libqb
		dev-libs/libsodium
		sys-libs/libseccomp
		sys-libs/libcap-ng
		qt4? ( sys-apps/usbguard-applet )"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable systemd) \
		--with-bundled-catch \
		--with-bundled-json \
		--with-bundled-pegtl \
		--with-bundled-spdlog
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install

	use systemd && systemd_dounit dist/usbguard.service

	insinto /etc/usbguard
	doins dist/usbguard-daemon.conf
}
