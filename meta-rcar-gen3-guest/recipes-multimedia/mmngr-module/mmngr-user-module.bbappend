MMNGR_DRV_URI = "git://github.com/renesas-rcar/mmngr_drv.git"

SRC_URI_append = " ${MMNGR_DRV_URI};branch=rcar_gen3;destsuffix=mmngr_drv;name=mmngr_drv"
SRCREV_mmngr_drv = "73937c754f9cb7b2ab8b186d6949cc23e1a095db"

CFLAGS += " -I${WORKDIR}/mmngr_drv/mmngr_drv/mmngr/mmngr-module/files/mmngr/include"

DEPENDS_remove = " \
    kernel-module-mmngr \
"
