# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

# Overrides
PRODUCT_MODEL := PDI-PXT
PRODUCT_NAME := ar6mx
PRODUCT_DEVICE := ar6mx
PRODUCT_MANUFACTURER := PDi Communication Systems, Inc.
PRODUCT_BRAND := PDi-Tab

PRODUCT_COPY_FILES += \
	device/bcm/ar6mx/required_hardware.xml:system/etc/permissions/required_hardware.xml \
	device/bcm/ar6mx/init.rc:root/init.freescale.rc \
	device/bcm/ar6mx/fstab.bcm:root/fstab.freescale \
	device/bcm/ar6mx/audio_policy.conf:system/etc/audio_policy.conf \
	device/bcm/ar6mx/audio_effects.conf:system/vendor/etc/audio_effects.conf \
	device/bcm/EETI/eGalaxTouch_VirtualDevice.idc:system/usr/idc/eGalaxTouch_VirtualDevice.idc \
        device/bcm/EETI/eGTouchA.ini:data/eGTouchA.ini \
        device/bcm/EETI/eGTouchD:system/bin/eGTouchD \
	device/bcm/ar6mx/process_ts.sh:system/etc/process_ts.sh \
	device/bcm/ar6mx/load_wifi_module.sh:system/etc/load_wifi_module.sh \
	device/bcm/ar6mx/dhcpcd.conf:system/etc/dhcpcd/dhcpcd.conf \
	device/bcm/ar6mx/ota.conf:data/system/ota.conf

# GPU files

DEVICE_PACKAGE_OVERLAYS := device/bcm/ar6mx/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.location.xml:system/etc/permissions/android.hardware.location.xml \
	frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# for PDK build, include only when the dir exists
# too early to use $(TARGET_BUILD_PDK)
ifneq ($(wildcard packages/wallpapers/LivePicker),)
PRODUCT_COPY_FILES += \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:system/etc/permissions/android.software.live_wallpaper.xml
endif

PRODUCT_PACKAGES += \
		    AudioRoute \
		    libhardware_legacy \
		    libnetcmdiface \
		    libcrypto \
		    libnetcmdiface

# Atmel Touchscreen packages
PRODUCT_PACKAGES += \
		    libusb \
 		    libmaxtouch \
 		    libmaxtouch-jni \
 		    mxt-app
 
# Extra Wireless Configuration Packages
PRODUCT_PACKAGES += \
		   wpa_cli \
		   iw

# Wifi Configuration files, for atheros, replace intel...is there a way to have both ifeq does not work here
# ... is this file processed after AR6MXBoardConfigComm.mk
PRODUCT_COPY_FILES += \
                   vendor/atheros/wifi/wpa_supplicant.conf:/data/misc/wifi/wpa_supplicant.conf \
                   vendor/atheros/wifi/hostapd.conf:/data/misc/wifi/hostapd.conf \
                   vendor/atmel/touchscreen/touchscreen.xcfg:/system/etc/touchscreen.xcfg

# Touchscreen configuration files
PRODUCT_COPY_FILES += \
		  vendor/atmel/touchscreen/touchscreen.xcfg:/system/etc/touchscreen.xcfg

# Add sample data files
PRODUCT_COPY_FILES += \
		  vendor/pdi/data/littlewomenormeg00alcoiala.epub:system/media/text/littlewomenormeg00alcoiala.epub

# Packages for all builds that add variety, fun, and spice to the PDi-Tab
PRODUCT_PACKAGES += 		\
com.adobe.reader_10.6.1                 \
org.jtb.alogcat_43                      \
org.petero.droidfish_54                 \
com.pdiarm.clone                        \
com.pdiarm.clonemaster                  \
com.pdiarm.cloneslave                   \
com.davidgoemans.simpleClockWidget      \
net.micode.fileexplorer_1               \
org.jfedor.frozenbubble_13              \
com.pdiarm.newuserconfirmation          \
OpenSudoku-1.1.5-01                     \
com.mobilepearls.sokoban                \
jackpal.androidterm_53                  \
org.androidappdev.wifiwidget            \
caa-2.1.2-597-us_zeebox                 \
com.pdiarm.systembackupandrestore 	\
BackupRestoreConfirmationPDi		\
ethernet				\
ReplicaIsland				\
cci-test 				\
android-support-v4			\
android-support-v7-appcompat		\
android-support-v7-gridlayout		\
android-support-v7-mediarouter		\
android-support-v8-renderscript		\
android-support-v13			\
procstatlog				\
tomdroid				\
k9					\
com.ghostsq.commander			\
fbreader				\
ghost-sftp-plugin			\
ghost-dropbox-plugin			\
ghost-box-plugin			\
ghost-google-drive-plugin		\
ghost-samba-plugin

# Packages for engineering only builds
PRODUCT_PACKAGES += \
		 sl4a

# Packages to include if the build is TVRC
ifeq ($(TVRC_BUILD),T)
$(warning Adding TVRC packages)
   PRODUCT_PACKAGES += omicron-V1_1_21	\
		       su \
		       Superuser 
$(warning Copying TVRC specific data files)
   PRODUCT_COPY_FILES += vendor/tvrc/su.sqlite:/data/data/com.thirdparty.superuser/databases/su.sqlite \
		         vendor/tvrc/superuser.sqlite:/data/data/com.thirdparty.superuser/databases/superuser.sqlite \
			 vendor/tvrc/su.sqlite-journal:/data/data/com.thirdparty.superuser/databases/su.sqlite-journal \
			 vendor/tvrc/superuser.sqlite-journal:/data/data/com.thirdparty.superuser/databases/superuser.sqlite-journal
endif

# Packages to include if the build is NOT TVRC
ifneq ($(TVRC_BUILD),T)
$(warning Adding packages for non-TVRC build like cci-test)
   #PRODUCT_PACKAGES +=
endif

PRODUCT_PROPERTY_OVERRIDES += hw.nobattery=true
PRODUCT_PROPERTY_OVERRIDES += sys.device.type=tablet
