#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/soc/imx6dq.mk
include device/bcm/ar6mx/build_id.mk
include device/bcm/ar6mx/AR6MXBoardConfigComm.mk
include device/fsl-proprietary/gpu-viv/fsl-gpu.mk

BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0


ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
#UBI boot command line.
BOARD_KERNEL_CMDLINE := console=ttymxc0,115200 init=/init video=mxcfb0 video=mxcfb1:off video=mxcfb2:off fbmem=10M fb0base=0x27b00000 vmalloc=400M androidboot.console=ttymxc0  mtdparts=gpmi-nand:20m(bootloader),20m(bootimg),20m(recovery),-(root) gpmi_debug_init ubi.mtd=3
endif

TARGET_KERNEL_DEFCONF := ar6mx_android_defconfig
TARGET_BOOTLOADER_CONFIG := 6q:mx6q_ar6mx_android_config 6solo:mx6solo_ar6mx_android_config

# Filesystem and partitioning
#BOARD_SYSTEMIMAGE_PARTITION_SIZE	:= 512M
BOARD_USERDATAIMAGE_PARTITION_SIZE	:= 512M
BOARD_CACHEIMAGE_PARTITION_SIZE		:= 256M
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE	:= ext4
BOARD_FLASH_BLOCK_SIZE 			:= 4096
TARGET_USERIMAGES_USE_EXT4		:= true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED	:= true

# System
TARGET_NO_RECOVERY			:= true
TARGET_PROVIDES_INIT_RC			:= true
