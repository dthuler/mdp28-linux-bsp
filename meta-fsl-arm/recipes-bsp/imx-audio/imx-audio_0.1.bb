SUMMARY = "Provide a basic init script to enable audio"
DESCRIPTION = "Set the volume and unmute the Front mixer setting during boot."
SECTION = "base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58"

PR = "r4"

inherit update-rc.d

RDEPENDS_${PN} = "alsa-utils-amixer"

SRC_URI = "file://imx-audio"

INITSCRIPT_NAME = "imx-audio"
INITSCRIPT_PARAMS = "defaults 90"

COMPATIBLE_MACHINE = "(mx5|mx6)"
INHIBIT_DEFAULT_DEPS = "1"

do_install() {
	install -d ${D}${sysconfdir} \
	           ${D}${sysconfdir}/init.d
	install -m 0755 ${WORKDIR}/imx-audio ${D}${sysconfdir}/init.d
        cat ${WORKDIR}/${INITSCRIPT_NAME} | \
            sed -e 's,/etc,${sysconfdir},g' \
                -e 's,/usr/sbin,${sbindir},g' \
                -e 's,/var,${localstatedir},g' \
                -e 's,/usr/bin,${bindir},g' \
                -e 's,/usr,${prefix},g' > ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
        chmod 755 ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
}

