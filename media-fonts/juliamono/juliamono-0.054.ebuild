# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FONT_SUFFIX="ttf"

inherit font

DESCRIPTION="JuliaMono - a monospaced font for scientific and technical computing"
HOMEPAGE="
	https://juliamono.netlify.app/
	https://github.com/cormullion/juliamono
"
SRC_URI="
	https://github.com/cormullion/juliamono/releases/download/v${PV}/JuliaMono-ttf.tar.gz -> ${PN}-ttf-${PV}.tar.gz
"

S="${WORKDIR}"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"
