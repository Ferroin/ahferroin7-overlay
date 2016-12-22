# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit toolchain-funcs

DESCRIPTION="A simple, tiny (~250 lines of code) inetd based HTTP seerver."
HOMEPAGE="http://acme.com/software/micro_httpd/"
SRC_URI="http://acme.com/software/micro_httpd/micro_httpd_14Aug2014.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
virtual/inetd
${DEPEND}"

S="${WORKDIR}/${PN}"

src_configure() {
# No configure script since it's ANSI C and portable to pretty much any
# UNIX-like system.
	true;
}

src_compile() {
# micro_httpd uses variable in it's Makefile to control where things
# go and what flags to use, and given that it's not been touched by the
# developer in years, it's not likely to change.
# Given that it's a single source file, it's much easier to just compile
# it by hand than to patch the Makefile.
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -ansi -pedantic -U__STRICT_ANSI__ -o ${PN} ${PN}.c || die
}

src_install() {
	dobin micro_httpd
	doman micro_httpd.8
	dodoc README
}
