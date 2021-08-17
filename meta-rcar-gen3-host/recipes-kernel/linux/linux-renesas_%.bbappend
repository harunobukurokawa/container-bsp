FILESEXTRAPATHS_prepend := "${THISDIR}/linux:"

SRC_URI_append = " file://lxc.cfg \
           "
KERNEL_CONFIG_FRAGMENTS_append = " \
             ${WORKDIR}/lxc.cfg \

SRC_URI_append = " \
    ${@oe.utils.conditional("DISABLE_RPC_ACCESS", "1", "", " file://hyperflash.cfg", d)} \
    file://nvme.cfg \
    file://imr.cfg \
    file://disable-unused.cfg \
    file://enable.cfg \
    file://renesas.scc \
"

SRC_URI_append_h3ulcb = " file://ulcb.cfg"
SRC_URI_append_m3ulcb = " file://ulcb.cfg"
SRC_URI_append_m3nulcb = " file://ulcb.cfg"
SRC_URI_append_salvator-x = " file://salvator-x.cfg"

"

ULCB_KF_DTBO = " \
    renesas/ulcb-kf-panel-mitsubishi-aa104xd12-1024x768.dtbo \
    renesas/ulcb-kf-panel-mitsubishi-aa121td01-1280x800.dtbo \
    renesas/ulcb-kf-panel-koe-tx31d200vm0baa-1280x480.dtbo \
    renesas/ulcb-kf-cn10-gmsl2.dtbo \
    renesas/ulcb-kf-cn10-pca.dtbo \
    renesas/ulcb-kf-cn11.dtbo \
    renesas/ulcb-kf-cn11-gmsl2.dtbo \
    renesas/ulcb-kf-cn11-pca.dtbo \
    renesas/ulcb-kf-most.dtbo \
    renesas/ulcb-kf-sd3.dtbo \
    renesas/ulcb-kf-imx219.dtbo \
"

KERNEL_DEVICETREE_append_h3ulcb = " \
    renesas/r8a77950-ulcb-kf.dtb \
    renesas/r8a77951-ulcb-kf.dtb \
    renesas/r8a779m1-ulcb-kf.dtb \
    ${ULCB_KF_DTBO} \
"

KERNEL_DEVICETREE_append_m3ulcb = " \
    renesas/r8a77960-ulcb-kf.dtb \
    renesas/r8a77961-ulcb-kf.dtb \
    ${ULCB_KF_DTBO} \
"

KERNEL_DEVICETREE_append_m3nulcb = " \
    renesas/r8a77965-ulcb-kf.dtb \
    ${ULCB_KF_DTBO} \
"

# Prefer generic-uio driver over kernel drivers
KERNEL_MODULE_PROBECONF_append = " rcar_imr"
KERNEL_MODULE_PROBECONF_append = " rcar_csi2"
KERNEL_MODULE_PROBECONF_append = " rcar_vin"
KERNEL_MODULE_PROBECONF_append = " vsp1"
KERNEL_MODULE_PROBECONF_append = " rcar-du-drm"
KERNEL_MODULE_PROBECONF_append = " rcar_lvds"
module_conf_rcar_imr = "blacklist rcar_imr"
module_conf_rcar_csi2 = "blacklist rcar_csi2"
module_conf_rcar_vin = "blacklist rcar_vin"
module_conf_vsp1 = "blacklist vsp1"
module_conf_rcar-du-drm = "blacklist rcar-du-drm"
module_conf_rcar_lvds = "blacklist rcar_lvds"

KERNEL_MODULE_AUTOLOAD_append = " uio_pdrv_genirq"
KERNEL_MODULE_PROBECONF_append = " uio_pdrv_genirq"
module_conf_uio_pdrv_genirq_append = 'options uio_pdrv_genirq of_id="generic-uio"'

# Install RCAR Gen3 specific UAPI headers
do_install_append_rcar-gen3() {
    install -d ${D}/usr/include/linux/
    install -m 0644 ${STAGING_KERNEL_DIR}/include/uapi/linux/rcar-imr.h ${D}/usr/include/linux/
}

PACKAGES += "${PN}-uapi"
FILES_${PN}-uapi = "/usr/include"
