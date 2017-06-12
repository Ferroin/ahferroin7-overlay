# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3 versionator

DESCRIPTION="Qt applet for interacting with the usbguard daemon."
HOMEPAGE="https://github.com/dkopecek/usbguard-applet-qt"
MY_AUTHOR="dkopecek"
EGIT_REPO_URI="https://github.com/${MY_AUTHOR}/${PN}-qt.git"

DEPEND="virtual/pkgconfig
		dev-qt/qtgui:4"

if [[ ${PV} == "9999" ]] ; then
	EGIT_BRANCH="master"
	KEYWORDS=""

	RDEPEND="${DEPEND}
			=sys-apps/usbguard-9999"
else
	MAJOR_V="$(get_version_component_range 1 ${PV})"
	MINOR_V="$(get_version_component_range 2 ${PV})"
	PATCH_V="$(get_version_component_range 3 ${PV})"
	EGIT_COMMIT="v${MAJOR_V}.${MINOR_V}${PATCH_V}"

	KEYWORDS="~x86 ~amd64"
	RDEPEND="${DEPEND}
			>=sys-apps/usbguard-${MAJOR_V}.${MINOR_V}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_configure() {
	local mycmakeargs=(
		-Wno-dev
	)

	cmake-utils_src_configure
}

src_install() {
	domenu "${FILESDIR}/usbguard-applet-qt.desktop"
	newicon src/icon.svg usbguard-applet.svg
	newicon src/icon-warning.svg usbguard-applet-warning.svg

	cmake-utils_src_install
}
