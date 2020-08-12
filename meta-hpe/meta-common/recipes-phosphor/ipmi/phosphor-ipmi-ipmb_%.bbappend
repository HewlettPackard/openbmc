FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Pin to Commit - bbfd00abdbc6d2f7c0389eae91cc055a1d4fe0c3
# Per mqueue slave driver design
SRCREV = "bbfd00abdbc6d2f7c0389eae91cc055a1d4fe0c3"

SRC_URI += "file://ipmb-channels.json \
            file://0001-Fix-unlimit-error-message-while-wrong-address.patch \
            "

do_install_append(){
    install -m 0644 -D ${WORKDIR}/ipmb-channels.json ${D}/usr/share/ipmbbridge
}
