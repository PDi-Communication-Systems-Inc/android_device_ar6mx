
#
# Product-specific compile-time definitions.
#

include device/fsl/imx6/BoardConfigCommon.mk

TARGET_BOOTLOADER_BOARD_NAME := AR6MX

#Override camera default in freescale config
BOARD_CAMERA_LIBRARIES := libcamera2

# Wifi
#BOARD_WLAN_VENDOR 			 := ATHEROS
BOARD_WLAN_VENDOR 			 := INTEL

ifeq ($(BOARD_WLAN_VENDOR),ATHEROS)
BOARD_WLAN_DEVICE            := qcwcn
WPA_SUPPLICANT_VERSION       := VER_0_8_X
WIFI_DRIVER_MODULE_PATH              := "/system/lib/modules/ath9k,ko"
WIFI_DRIVER_MODULE_PATH_ATHEROS      := "/system/lib/modules/ath9k.ko"
WIFI_DRIVER_MODULE_NAME              := "ath9k"
WIFI_DRIVER_MODULE_NAME_ATHEROS      := "ath9k"
WIFI_DRIVER_MODULE_ARG               := "nohwcrypt=1 btcoex_enable=1 debug=0xffffffff"
WIFI_DRIVER_MODULE_ARG_ATHEROS       := "nohwcrypt=1 btcoex_enable=1 debug=0xffffffff"
#WIFI_DRIVER_P2P_MODULE_ARG_ATHEROS   := "nohwcrypt=1 btcoex_enable=1 debug=0xffffffff"
#WIFI_DRIVER_P2P_MODULE_ARG           := "nohwcrypt=1 btcoex_enable=1 debug=0xffffffff"
WIFI_SDIO_IF_DRIVER_MODULE_PATH      := "/system/lib/modules/cfg80211.ko"
WIFI_SDIO_IF_DRIVER_MODULE_PATH_ATHEROS := "/system/lib/modules/cfg80211.ko"
WIFI_SDIO_IF_DRIVER_MODULE_NAME := "cfg80211"
WIFI_SDIO_IF_DRIVER_MODULE_ARG  := ""
WIFI_COMPAT_MODULE_PATH  := "/system/lib/modules/compat.ko"
WIFI_COMPAT_MODULE_NAME  := "compat"
WIFI_COMPAT_MODULE_ARG   := ""
WIFI_TEST_INTERFACE      := "sta"
TARGET_KERNEL_MODULES        := \
				backports-3.14-1/drivers/net/wireless/ath/ath9k/ath9k.ko:system/lib/modules/ath9k.ko \
				backports-3.14-1/drivers/net/wireless/ath/ath9k/ath9k_hw.ko:system/lib/modules/ath9k_hw.ko \
				backports-3.14-1/drivers/net/wireless/ath/ath9k/ath9k_common.ko:system/lib/modules/ath9k_common.ko \
				backports-3.14-1/drivers/net/wireless/ath/ath10k/ath10k_pci.ko:system/lib/modules/ath10k_pci.ko \
				backports-3.14-1/drivers/net/wireless/ath/ath10k/ath10k_core.ko:system/lib/modules/ath10k_core.ko \
				backports-3.14-1/drivers/net/wireless/ath/ath.ko:system/lib/modules/ath.ko \
				backports-3.14-1/net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
				backports-3.14-1/compat/compat.ko:system/lib/modules/compat.ko \
				backports-3.14-1/compat/crc8.ko:system/lib/modules/crc8.ko \
				backports-3.14-1/compat/cordic.ko:system/lib/modules/cordic.ko \
				backports-3.14-1/net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
				backports-3.14-1/drivers/bluetooth/btusb.ko:system/lib/modules/btusb.ko \
				backports-3.14-1/drivers/bluetooth/btsdio.ko:system/lib/modules/btsdio.ko \
				backports-3.14-1/drivers/bluetooth/bfusb.ko:system/lib/modules/bfusb.ko \
				backports-3.14-1/drivers/bluetooth/bcm203x.ko:system/lib/modules/bcm203x.ko \
				backports-3.14-1/drivers/bluetooth/btmrvl_sdio.ko:system/lib/modules/btmrvl_sdio.ko \
				backports-3.14-1/drivers/bluetooth/bpa10x.ko:system/lib/modules/bpa10x.ko \
				backports-3.14-1/drivers/bluetooth/btmrvl.ko:system/lib/modules/btmrvl.ko \
				backports-3.14-1/drivers/bluetooth/hci_vhci.ko:system/lib/modules/hci_vhci.ko \
				backports-3.14-1/drivers/bluetooth/ath3k.ko:system/lib/modules/ath3k.ko \
				backports-3.14-1/net/bluetooth/rfcomm/rfcomm.ko:system/lib/modules/rfcomm.ko \
				backports-3.14-1/net/bluetooth/bnep/bnep.ko:system/lib/modules/bnep.ko \
				backports-3.14-1/net/bluetooth/hidp/hidp.ko:system/lib/modules/hidp.ko \
				backports-3.14-1/net/bluetooth/bluetooth.ko:system/lib/modules/bluetooth.ko \
				backports-3.14-1/net/ieee802154/6lowpan_iphc.ko:system/lib/modules/6lowpan_iphc.ko \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x01020001.dfu:system/etc/firmware/ar3k/AthrBT_0x01020001.dfu \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x01020200.dfu:system/etc/firmware/ar3k/AthrBT_0x01020200.dfu \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x01020201.dfu:system/etc/firmware/ar3k/AthrBT_0x01020201.dfu \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x11020000.dfu:system/etc/firmware/ar3kAthrBT_0x11020000.dfu \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x31010000.dfu:system/etc/firmware/ar3k/AthrBT_0x31010000.dfu \
				vendor/atheros/bluetooth/ar3k/AthrBT_0x41020000.dfu:system/etc/firmware/ar3k/AthrBT_0x41020000.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x01020201_40.dfu:system/etc/firmware/ar3k/ramps_0x01020201_40.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x11020000_40.dfu:system/etc/firmware/ar3k/ramps_0x11020000_40.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x01020001_26.dfu:system/etc/firmware/ar3k/ramps_0x01020001_26.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x01020201_26.dfu:system/etc/firmware/ar3k/ramps_0x01020201_26.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x01020200_40.dfu:system/etc/firmware/ar3k/ramps_0x01020200_40.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x01020200_26.dfu:system/etc/firmware/ar3k/ramps_0x01020200_26.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x41020000_40.dfu:system/etc/firmware/ar3k/ramps_0x41020000_40.dfu \
				vendor/atheros/bluetooth/ar3k/ramps_0x31010000_40.dfu:system/etc/firmware/ar3k/ramps_0x31010000_40.dfu

BOARD_WPA_SUPPLICANT_DRIVER  := NL80211
BOARD_HOSTAPD_DRIVER         := NL80211

BOARD_HOSTAPD_PRIVATE_LIB_QCOM              := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_PRIVATE_LIB_QCOM       := lib_driver_cmd_qcwcn
endif

ifeq ($(BOARD_WLAN_VENDOR),INTEL)
WIFI_ROOT                               := backports-3.14-1
#WIFI_ROOT                                := external/intel_iwlwifi
INTEL_FIRMWARE_BINARY_LOC                := /system/etc/firmware/iwlwifi-3160-8.ucode
#WIFI_DRIVER_FW_PATH_STA                  := $(INTEL_FIRMWARE_BINARY_LOC)
#WIFI_DRIVER_FW_PATH_AP                   := $(INTEL_FIRMWARE_BINARY_LOC)
#WIFI_DRIVER_FW_PATH_P2P                  := $(INTEL_FIRMWARE_BINARY_LOC)
WIFI_DRIVER_FW_PATH_PARAM                := /system/etc/firmware/
BOARD_WLAN_DEVICE                        := INTEL
BOARD_WPA_SUPPLICANT_DRIVER              := NL80211
WPA_SUPPLICANT_VERSION                   := VER_0_8_X
HOSTAPD_VERSION                          := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB         := private_lib_driver_cmd_intel
#BOARD_HOSTAPD_PRIVATE_LIB                ?= private_lib_driver_cmd_intel
TARGET_KERNEL_MODULES                    := \
					    $(WIFI_ROOT)/drivers/net/wireless/iwlwifi/iwlwifi.ko:system/lib/modules/iwlwifi.ko \
					    $(WIFI_ROOT)/drivers/net/wireless/iwlwifi/mvm/iwlmvm.ko:system/lib/modules/iwlmvm.ko \
					    $(WIFI_ROOT)/drivers/net/wireless/iwlwifi/dvm/iwldvm.ko:system/lib/modules/iwldvm.ko \
					    $(WIFI_ROOT)/net/mac80211/mac80211.ko:system/lib/modules/mac80211.ko \
                                	    $(WIFI_ROOT)/compat/compat.ko:system/lib/modules/compat.ko \
                                	    $(WIFI_ROOT)/compat/crc8.ko:system/lib/modules/crc8.ko \
                                	    $(WIFI_ROOT)/compat/cordic.ko:system/lib/modules/cordic.ko \
					    $(WIFI_ROOT)/compat/sch_fq_codel.ko:system/lib/modules/sch_fs_codel.ko \
					    $(WIFI_ROOT)/compat/sch_codel.ko:system/lib/modules/sch_codel.ko \
					    $(WIFI_ROOT)/net/wireless/cfg80211.ko:system/lib/modules/cfg80211.ko \
                                	    $(WIFI_ROOT)/drivers/bluetooth/btusb.ko:system/lib/modules/btusb.ko \
					    $(WIFI_ROOT)/net/bluetooth/rfcomm/rfcomm.ko:system/lib/modules/rfcomm.ko \
                                	    $(WIFI_ROOT)/net/bluetooth/bnep/bnep.ko:system/lib/modules/bnep.ko \
                                	    $(WIFI_ROOT)/net/bluetooth/hidp/hidp.ko:system/lib/modules/hidp.ko \
                                	    $(WIFI_ROOT)/net/bluetooth/bluetooth.ko:system/lib/modules/bluetooth.ko \
					    vendor/intel/iwlwifi-1000-3.ucode:system/etc/firmware/iwlwifi-1000-3.ucode \
					    vendor/intel/iwlwifi-1000-5.ucode:system/etc/firmware/iwlwifi-1000-5.ucode \
					    vendor/intel/iwlwifi-100-5.ucode:system/etc/firmware/iwlwifi-100-5.ucode \
					    vendor/intel/iwlwifi-105-6.ucode:system/etc/firmware/iwlwifi-105-6.ucode \
					    vendor/intel/iwlwifi-135-6.ucode:system/etc/firmware/iwlwifi-135-6.ucode \
					    vendor/intel/iwlwifi-2000-6.ucode:system/etc/firmware/iwlwifi-2000-6.ucode \
					    vendor/intel/iwlwifi-2030-6.ucode:system/etc/firmware/iwlwifi-2030-6.ucode \
					    vendor/intel/iwlwifi-3160-7.ucode:system/etc/firmware/iwlwifi-3160-7.ucode \
					    vendor/intel/iwlwifi-3160-8.ucode:system/etc/firmware/iwlwifi-3160-8.ucode \
					    vendor/intel/iwlwifi-3945-2.ucode:system/etc/firmware/iwlwifi-3945-2.ucode \
					    vendor/intel/iwlwifi-4965-2.ucode:system/etc/firmware/iwlwifi-4965-2.ucode \
					    vendor/intel/iwlwifi-5000-1.ucode:system/etc/firmware/iwlwifi-5000-1.ucode \
					    vendor/intel/iwlwifi-5000-2.ucode:system/etc/firmware/iwlwifi-5000-2.ucode \
					    vendor/intel/iwlwifi-5150-2.ucode:system/etc/firmware/iwlwifi-5150-2.ucode \
					    vendor/intel/iwlwifi-6000-4.ucode:system/etc/firmware/iwlwifi-6000-4.ucode \
					    vendor/intel/iwlwifi-6000g2a-5.ucode:system/etc/firmware/iwlwifi-6000g2a-5.ucode \
					    vendor/intel/iwlwifi-6000g2a-6.ucode:system/etc/firmware/iwlwifi-6000g2a-6.ucode \
					    vendor/intel/iwlwifi-6000g2b-5.ucode:system/etc/firmware/iwlwifi-6000g2b-5.ucode \
					    vendor/intel/iwlwifi-6000g2b-6.ucode:system/etc/firmware/iwlwifi-6000g2b-6.ucode \
					    vendor/intel/iwlwifi-6050-4.ucode:system/etc/firmware/iwlwifi-6050-4.ucode \
					    vendor/intel/iwlwifi-6050-5.ucode:system/etc/firmware/iwlwifi-6050-5.ucode \
					    vendor/intel/iwlwifi-7260-7.ucode:system/etc/firmware/iwlwifi-7260-7.ucode \
					    vendor/intel/iwlwifi-7260-8.ucode:system/etc/firmware/iwlwifi-7260-8.ucode \
					    vendor/intel/bt/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq:system/etc/firmware/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq \
					    vendor/intel/bt/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq:system/etc/firmware/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq \
					    vendor/intel/bt/ibt-hw-37.7.bseq:system/etc/firmware/ibt-hw-37.7.bseq
#WIFI_DRIVER_MODULE_PATH                  := "/system/lib/modules/iwlwifi.ko"
#WIFI_DRIVER_MODULE_NAME                  := "iwlwifi"
#WIFI_DRIVER_MODULE_ARG                   := "debug=0xf bt_coex_active=true"
endif

BOARD_MODEM_VENDOR := AMAZON

BOARD_HAVE_HARDWARE_GPS := false
USE_ATHR_GPS_HARDWARE := false
USE_QEMU_GPS_HARDWARE := false

#for accelerator sensor, need to define sensor type here
BOARD_HAS_SENSOR := false
SENSOR_MMA8451 := false

# for recovery service
TARGET_SELECT_KEY := 28

TARGET_USERIMAGES_USE_EXT4 := true

# uncomment below lins if use NAND
#TARGET_USERIMAGES_USE_UBIFS = true

ifeq ($(TARGET_USERIMAGES_USE_UBIFS),true)
UBI_ROOT_INI := device/bcm/ar6mx/ubi/ubinize.ini
TARGET_MKUBIFS_ARGS := -m 4096 -e 516096 -c 4096 -x none
TARGET_UBIRAW_ARGS := -m 4096 -p 512KiB $(UBI_ROOT_INI)
endif

BOARD_HAVE_BLUETOOTH := true

# atheros 3k BT
ifeq ($(BOARD_WLAN_VENDOR),ATHEROS)
  BOARD_USE_AR3K_BLUETOOTH := true
endif

USE_ION_ALLOCATOR := false
USE_GPU_ALLOCATOR := true
