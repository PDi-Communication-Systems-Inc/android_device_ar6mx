PRODUCT_COPY_FILES += \
	device/bcm/ar6mx/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/bcm/ar6mx/init.rc:root/init.freescale.rc \
    	device/bcm/ar6mx/vold.fstab:system/etc/vold.fstab \
	device/bcm/ar6mx/gpsreset.sh:system/etc/gpsreset.sh

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/bcm/ar6mx/overlay
