VSPMIF_DRV_URL = " \
    git://github.com/renesas-rcar/vspmif_drv.git"
BRANCH = "rcar_gen3"
SRCREV_vspmif_drv = "34bd0c4333c3be7531702e8d70867c6ea742a558"


VSPM_DRV_URL = "git://github.com/renesas-rcar/vspm_drv.git"
SRCREV_vspm_drv = "07787fc1168e7fe37c305aca151a6f756f35874f"

MMNGR_DRV_URI = "git://github.com/renesas-rcar/mmngr_drv.git"
SRCREV_mmngr_drv = "73937c754f9cb7b2ab8b186d6949cc23e1a095db"

SRC_URI_append = " \
    ${VSPMIF_DRV_URL};branch=${BRANCH};destsuffix=vspmif_drv;name=vspmif_drv \
    ${VSPM_DRV_URL};branch=${BRANCH};destsuffix=vspm_drv;name=vspm_drv \
    ${MMNGR_DRV_URI};branch=rcar_gen3;destsuffix=mmngr_drv;name=mmngr_drv \
"

CFLAGS += " -I${WORKDIR}/vspmif_drv/vspm_if-module/files/vspm_if/include"
CFLAGS += " -I${WORKDIR}/vspm_drv/vspm-module/files/vspm/include/"

do_compile_prepend() {
    cp ${WORKDIR}/vspm_drv/vspm-module/files/vspm/include/vsp_drv.h ${S}/${VSPMIF_LIB_DIR}/include
    cp ${WORKDIR}/vspm_drv/vspm-module/files/vspm/include/fdp_drv.h ${S}/${VSPMIF_LIB_DIR}/include
    cp ${WORKDIR}/vspm_drv/vspm-module/files/vspm/include/vspm_cmn.h ${S}/${VSPMIF_LIB_DIR}/include
    cp ${WORKDIR}/vspmif_drv/vspm_if-module/files/vspm_if/include/*.h ${S}/${VSPMIF_LIB_DIR}/include
    cp ${WORKDIR}/mmngr_drv/mmngr_drv/mmngr/mmngr-module/files/mmngr/include/*.h ${S}/${VSPMIF_LIB_DIR}/include
}

DEPENDS_remove = " \
    kernel-module-vspmif \
"
