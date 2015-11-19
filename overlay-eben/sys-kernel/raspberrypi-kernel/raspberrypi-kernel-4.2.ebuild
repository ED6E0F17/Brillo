# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="rpi-4.2.y"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="0227ee27e91cdd94626e390665e6f6e0f3395ce6"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi2-kms"
KEYWORDS="arm"
KERNEL="kernel7"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install
#	make bcm2709-rpi-2-b.dtb

        "${FILESDIR}/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/dtImage"

        insinto /boot
        doins "${FILESDIR}"/{cmdline,config}.txt
        doins "${T}/dtImage"
	doins "${FILESDIR}/bcm2709-rpi-2-b.dtb"
}