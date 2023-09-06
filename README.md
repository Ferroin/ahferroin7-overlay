# ahferroin7’s Portage overlay.

Some of the stuff in here is stuff that I wrote myself and am to lazy
to put in it's won repo, other stuff is versions that aren't (or weren't
at some point) availible in the regular protage tree.

## Using it

### With eselect repository

Just run `eselect repository add ahferroin7-overlay git https://github.com/Ferroin/ahferroin7-overlay`
to add the overlay to your system.

### With Layman

To use this with layman, you need to update your layman configuration to point at
https://raw.githubusercontent.com/Ferroin/ahferroin7-overlay/master/overlays.xml
as an additional unsigned overlay list.

## Contents

Currently, the things I've wrtten in here are:

- app-portage/check-reboot: Check to see if we've updated any of a set of packages and thus need to reboot.
- app-shells/powerline-service: Per-user Powerline daemons as OpenRC services.
- sys-apps/auto-swap: An initscript to do advanced swapfile setup.
- sys-apps/kdump-init: A simple (and somewhat naieve) initscript to set up and run kernel crash dumps.
- sys-apps/mm-init-scripts: A collection of init scripts to set up various Linux memory management features.
- sys-apps/zram-swap: An initscript to setup swap on a compressed ramdisk.
- sys-fs/fscleaner: A cron job to automate basic filesystem maintnence tasks.
