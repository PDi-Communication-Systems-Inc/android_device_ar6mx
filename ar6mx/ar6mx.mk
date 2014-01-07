# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

# Overrides
PRODUCT_NAME := ar6mx
PRODUCT_DEVICE := ar6mx
PRODUCT_BRAND := bcm
PRODUCT_MANUFACTURER := bcm

PRODUCT_COPY_FILES += \
	device/bcm/ar6mx/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/bcm/ar6mx/init.rc:root/init.freescale.rc \
	device/bcm/ar6mx/fstab.bcm:root/fstab.freescale \
	device/bcm/ar6mx/vold.fstab:system/etc/vold.fstab \
	device/bcm/ar6mx/gpsreset.sh:system/etc/gpsreset.sh

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/bcm/ar6mx/overlay

