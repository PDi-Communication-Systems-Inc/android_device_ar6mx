#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/bcm/ar6mx/build_id.mk
include device/bcm/ar6mx/AR6MXBoardConfigComm.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

ifneq (T,$(filter T, $(TELEHEALTH_BUILD)))
   ifeq ($(MAKE_SD_CARD),T)
      BOARD_KERNEL_CMDLINE := bootargs=console=ttymxc0,115200 init=/init video=mxcfb0:dev=hdmi,1280x720M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale fbmem=12M\0 
   else
      BOARD_KERNEL_CMDLINE := bootargs=console=ttymxc0,115200 init=/init emmc_en video=mxcfb0:dev=hdmi,1280x720M@60,if=RGB24,bpp=32 video=mxcfb1:off video=mxcfb2:off vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale fbmem=12M\0
   endif
else
   ifeq ($(MAKE_SD_CARD),T)
      BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0:dev=ldb,1366x768M@60,bpp=32 video=mxcfb2:dev=hdmi,1280x720M@60,bpp=32 video=mxcfb1:off vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale fbmem=13M,12M\0
   else
      BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init emmc_en video=mxcfb0:dev=ldb,1366x768M@60,bpp=32 video=mxcfb2:dev=hdmi,1280x720M@60,bpp=32 video=mxcfb1:off vmalloc=400M androidboot.console=ttymxc0 androidboot.hardware=freescale fbmem=13M,12M\0
   endif
endif

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
BOARD_KERNEL_CMDLINE := "console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0  mtdparts=gpmi-nand:20m(bootloader),20m(bootimg),20m(recovery),-(root) gpmi_debug_init ubi.mtd=3"
endif

TARGET_KERNEL_DEFCONF := ar6mx_android_defconfig
ifeq ($(PDI_SOLO),T)
   $(warning Setting target bootloader config to solo)
   TARGET_BOOTLOADER_CONFIG := 6solomfg:mx6solo_ar6mx_mfg_config 6solo:mx6solo_ar6mx_android_config
else
   $(warning Setting target bootloader config to quad)
   TARGET_BOOTLOADER_CONFIG := 6qmfg:mx6q_ar6mx_mfg_config 6q:mx6q_ar6mx_android_config
endif

# Filesystem and partitioning
BOARD_RECOVERY_PARTITION_SIZE 		:= 104900000
BOARD_CACHEIMAGE_PARTITION_SIZE         := 256000000
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE       := ext4

ifeq ($(EMMC_SIZE),8)
   BOARD_SYSTEMIMAGE_PARTITION_SIZE := 691574400
   BOARD_USERDATAIMAGE_PARTITION_SIZE := 3890000000
else
   BOARD_SYSTEMIMAGE_PARTITION_SIZE := 636870912
   BOARD_USERDATAIMAGE_PARTITION_SIZE := 536870912
endif

BOARD_FLASH_BLOCK_SIZE := 4096

# Boot animation optimizations
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true

# Perform JIT-ready optimizations of jar/apks at compile time
# Should reduce first-run boot but will increase compile times
WITH_DEXPREOPT=true

# User image options
TARGET_USERIMAGES_USE_EXT4		:= true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED	:= true

# System
TARGET_NO_RECOVERY			:= false
TARGET_PROVIDES_INIT_RC			:= true
TARGET_RECOVERY_FSTAB 			:= device/bcm/ar6mx/fstab.freescale
TARGET_RECOVERY_UPDATER_LIBS		:= librecovery_updater_ar6mx
TARGET_RECOVERY_PIXEL_FORMAT		:= "BGRA_8888"

# Widevine options
ifeq ($(WIDEVINE_SUPPORT),T)
   $(warning Setting widevine oem crypt to level 3)
   $(warning Telling system to build widvine oem crypto)
   BOARD_WIDEVINE_OEMCRYPTO_LEVEL := 3
   BUILD_WV_OEMCRYPTO_SRC = true
else 
   $(warning Widevine NOT Required, BoardConfig.mk)
endif
