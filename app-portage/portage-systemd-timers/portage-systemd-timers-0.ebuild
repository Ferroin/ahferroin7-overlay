# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of simple systemd timers for common Portage tasks"
HOMEPAGE="https://github.com/Ferroin/ahferroin7-overlay"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm ~arm64"
IUSE="+gentoolkit notify"

DEPEND=""
RDEPEND="${DEPEND}
gentoolkit? ( app-portage/gentoolkit )
notify? (
	|| ( x11-libs/libnotify x11-misc/tinynotify-send )
	sys-apps/dbus
)"
BDEPEND=""

inherit systemd

src_unpack() {
	S="${WORKDIR}"
}

src_install() {
	systemd_douserunit "${FILESDIR}"/${PV}/emerge-sync-done.target
	systemd_newunit "${FILESDIR}"/${PV}/emerge-sync-done.service emerge-sync-done@.service
	systemd_dounit "${FILESDIR}"/${PV}/emerge-sync-done.target
	systemd_dounit "${FILESDIR}"/${PV}/emerge-sync.service
	systemd_dounit "${FILESDIR}"/${PV}/emerge-sync.timer

	systemd_dounit "${FILESDIR}"/${PV}/trim-emerge-log.service
	systemd_dounit "${FILESDIR}"/${PV}/trim-emerge-log.timer

	systemd_douserunit "${FILESDIR}"/${PV}/glsa-notify.target
	systemd_newunit "${FILESDIR}"/${PV}/glsa-notify.service glsa-notify@.service
	systemd_dounit "${FILESDIR}"/${PV}/glsa-notify-mail.service
	systemd_dounit "${FILESDIR}"/${PV}/glsa-notify.target
	systemd_dounit "${FILESDIR}"/${PV}/glsa-check.service
	systemd_dounit "${FILESDIR}"/${PV}/glsa-check.timer

	if use gentoolkit; then
		for n in packages distfiles; do
			systemd_dounit "${FILESDIR}"/${PV}/eclean-${n}.service
			systemd_dounit "${FILESDIR}"/${PV}/eclean-${n}.timer
		done
	fi

	if use notify-send; then
		systemd_douserunit "${FILESDIR}"/${PV}/emerge-update-notify-desktop.service
		systemd_douserunit "${FILESDIR}"/${PV}/emerge-sync-notify-desktop.service
		systemd_douserunit "${FILESDIR}"/${PV}/glsa-notify-desktop.service
	fi
}

pkg_postinst() {
	if [ "${MERGE_TYPE}" != "buildonly" ]; then
		systemd_is_booted && systemctl daemon-reload
	fi

	if use notify; then
		einfo "For desktop notification delivery, the system emerge-sync-done@.service and glsa-notify@.service services must be enabled for users who should recieve notifications."
	fi
}
