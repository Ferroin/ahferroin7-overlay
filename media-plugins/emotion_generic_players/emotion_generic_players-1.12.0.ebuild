# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit enlightenment

MY_P=${PN}-${PV/_/-}

DESCRIPTION="Provides external applications as generic loaders for Evas"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="http://download.enlightenment.org/rel/libs/${PN}/${MY_P}.tar.bz2"

LOCENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-libs/efl-1.8.0_beta2
	media-video/vlc
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}
