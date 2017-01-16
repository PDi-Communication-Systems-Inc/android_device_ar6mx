# This is a FSL Android Reference Design platform based on i.MX6Q ARD board
# It will inherit from FSL core product which in turn inherit from Google generic

$(call inherit-product, device/fsl/imx6/imx6.mk)
$(call inherit-product-if-exists,vendor/google/products/gms.mk)

# Overrides

# Set MODEL by firmware part model
# if no BUILD defined PDI-PXT will be used
PRODUCT_MODEL := PDI-PXT
ifeq ($(STANDARD_BUILD),T)
    PRODUCT_MODEL := PD403-008
endif

ifeq ($(NIH_BUILD),T)
    PRODUCT_MODEL := PD403-009
endif

ifeq ($(TVRC_BUILD),T)
    PRODUCT_MODEL := PD403-010
endif

ifeq ($(DAVITA_BUILD),T)
    PRODUCT_MODEL := PD403-011
endif

ifeq ($(TELEHEALTH_BUILD),T)
    PRODUCT_MODEL := PD403-015
endif

ifeq ($(OPTIMAL_SOLUTIONS),T)
    PRODUCT_MODEL := PD403-016
endif

ifeq ($(SIMONETTO_BUILD),T)
    PRODUCT_MODEL := PD403-017
endif

ifeq ($(SIM_TS_BUILD),T)
    PRODUCT_MODEL := PD403-013
endif

ifeq ($(ARA_BUILD),T)
    PRODUCT_MODEL := PD403-012
endif

ifeq ($(MDM_BUILD),T)
    PRODUCT_MODEL := PD403-019
endif

ifeq ($(AT_BUILD),T)
    PRODUCT_MODEL := PD403-021
endif
$(warning Setting PRODUCT_MODEL to $(PRODUCT_MODEL))

# These values are not to be changed
PRODUCT_NAME := ar6mx
PRODUCT_DEVICE := ar6mx
PRODUCT_MANUFACTURER := PDi Communication Systems, Inc.
PRODUCT_BRAND := PDi-Tab

# Files to include in all images
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
	device/bcm/ar6mx/ota.conf:data/system/ota.conf \
	branding/bootanimation.zip:system/media/bootanimation.zip \
	vendor/pdi/idc/Vendor_0ac8_Product_3470.idc:system/usr/idc/Vendor_0ac8_Product_3470.idc \
	device/bcm/ar6mx/ntp.conf:/system/etc/ntp.conf \
	kernel_imx/drivers/input/touchscreen/atmel_mxt_ts.ko:/system/lib/modules/atmel_mxt_ts.ko \
	kernel_imx/drivers/watchdog/imx2_wdt.ko:/system/lib/modules/imx2_wdt.ko \
	kernel_imx/drivers/watchdog/softdog.ko:/system/lib/modules/softdog.ko \
	device/bcm/ar6mx/common/input/atmel_mxt_ts_T100_touchscreen.idc:system/usr/idc/atmel_mxt_ts_T100_touchscreen.idc \
	device/bcm/ar6mx/devregs_imx6x.dat:/system/etc/devregs_imx6x.dat

#Copy default device admin files
PRODUCT_COPY_FILES += \
	device/bcm/ar6mx/device_policies.xml:system/etc/device_policies.xml \
	device/bcm/ar6mx/copy_device_policies.sh:system/etc/copy_device_policies.sh
	
DEVICE_PACKAGE_OVERLAYS := device/bcm/ar6mx/overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_AAPT_CONFIG += xlarge large tvdpi hdpi xhdpi

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
	frameworks/native/data/etc/android.hardware.faketouch.xml:system/etc/permissions/android.hardware.faketouch.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
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

#Camera Drivers
PRODUCT_COPY_FILES += \
		  kernel_imx/drivers/media/video/mxc/capture/csi_v4l2_capture.ko:system/lib/modules/csi_v4l2_capture.ko \
		  kernel_imx/drivers/media/video/mxc/capture/fsl_csi.ko:system/lib/modules/fsl_csi.ko \
		  kernel_imx/drivers/media/video/mxc/capture/ov5640_camera_mipi.ko:system/lib/modules/ov5640_camera_mipi.ko \
		  kernel_imx/drivers/media/video/mxc/capture/ov5640_camera.ko:system/lib/modules/ov5640_camera.ko


# Packages for all builds that add variety, fun, and spice to the PDi-Tab
PRODUCT_PACKAGES += 		\
alogcat					\
com.pdiarm.clone                        \
com.pdiarm.clonemaster                  \
com.pdiarm.cloneslave                   \
com.davidgoemans.simpleClockWidget      \
net.micode.fileexplorer                 \
frozenbubble				\
libmodplug-1.0				\
org.moire.opensudoku.game		\
com.mobilepearls.sokoban                \
com.uberspot.a2048			\
com.mobilepearls.memory			\
com.faddensoft.breakout                 \
jackpal.androidterm			\
libjackpal-termexec2			\
libjackpal-androidterm5			\
com.pdiarm.systembackupandrestore 	\
BackupRestoreConfirmationPDi		\
ethernet				\
ReplicaIsland				\
android-support-v4			\
android-support-v7-appcompat		\
android-support-v7-gridlayout		\
android-support-v7-mediarouter		\
android-support-v8-renderscript		\
android-support-v13			\
procstatlog				\
fbreader				\
com.pdiarm.showusermessage		\
com.pdiarm.deleteme			\
VLC					\
todoTxtTouch				\
hn-android				\
usbreset				\
i2c-tools				\
i2cdetect				\
i2cget					\
i2cset					\
i2cdump					\
raidl					\
iperf					\
iperf3					\
pdicinchwidget.apps.android.pdiarm.com.pdicinchwidget \
com.pdiarm.pdicinchwidgets.pdixplain	\
com.example.puzzlegame			\
org.wikipedia				\
v4l2-ctl				\
v4l2-dbg				\
v4l2-compliance				\
libv4l2					\
libv4l_convert          		\
PicoTts                 		\
PicoLangInstaller

ifneq ($(ANDROID_BUILD_MODE),user) 
PRODUCT_PACKAGES += devregs	\
		    inputRead
endif

# Extra filesystem packages
PRODUCT_PACKAGES += \
		 e2fsck \
		 setup_fs

# Extra software based encoders
PRODUCT_PACKAGES += \
		 libstagefright_avcenc

# Packages to include if the build is NIH
ifeq ($(NIH_BUILD),T)
	PRODUCT_PACKAGES += \
		com.pdiarm.nihwebsite			\
		com.pdiarm.patientportal		\
		com.pdiarm.nutrition			\
		com.pdiarm.disclaimer			\
		com.pdiarm.patientfeedback		\
		com.adobe.reader_10.6.1			\
		com.kmagic.solitaire_450
else
	PRODUCT_PACKAGES += \
		AdobeReader \
		org.petero.droidfish-1.61-69
endif 

# Packages to include if the build is Davita
ifeq ($(DAVITA_BUILD),T)
	PRODUCT_PACKAGES += \
		com.kmagic.solitaire_450			
else 

# Packages to include if the build is not Davita
# they do not want email packages for instance
$(warning Not a Davita build, adding some other packages)
	PRODUCT_PACKAGES += \
		k9				\
		org.tomdroid			\
		ghostcommander			\
		ghost-sftp-plugin               \
		ghost-dropbox-plugin            \
		ghost-box-plugin                \
		ghost-google-drive-plugin       \
		ghost-samba-plugin		\
		Email				\
		Exchange2
endif

# Packages to include if the build is TVRC
ifeq ($(TVRC_BUILD),T)
$(warning Adding TVRC packages)
   PRODUCT_PACKAGES += omicron-V1_2_4 \
		       su \
		       Superuser 
$(warning Copying TVRC specific data files)
   PRODUCT_COPY_FILES += vendor/tvrc/su.sqlite:/data/data/com.thirdparty.superuser/databases/su.sqlite \
		         vendor/tvrc/superuser.sqlite:/data/data/com.thirdparty.superuser/databases/superuser.sqlite \
			 vendor/tvrc/su.sqlite-journal:/data/data/com.thirdparty.superuser/databases/su.sqlite-journal \
			 vendor/tvrc/superuser.sqlite-journal:/data/data/com.thirdparty.superuser/databases/superuser.sqlite-journal
endif

# Packages to include if the build is Telehealth
ifeq ($(TELEHEALTH_BUILD),T)
$(warning Adding TELEHEALTH packages)
    PRODUCT_PACKAGES += su \
                        Superuser
endif

# Packages to include if the build is Optimal
ifeq ($(OPTIMAL_BUILD),T)
$(warning Adding OPTIMAL packages)
    PRODUCT_PACKAGES += su \
                        Superuser
endif

# Packages to include if the build is Simonetto
ifeq ($(SIMONETTO_BUILD),T)
$(warning Adding packages for Simonetto Build)
   PRODUCT_PACKAGES += psreader
endif

# Check to add PDi Store or not
$(warning $(filter T, $(TVRC_BUILD) $(TELEHEALTH_BUILD) $(MDM_BUILD)))
ifneq (T,$(filter T, $(TVRC_BUILD) $(TELEHEALTH_BUILD) $(MDM_BUILD)))
$(warning Adding PDi Store agent to build)
   PRODUCT_PACKAGES += org.wso2.emm.agent
else 
$(warning Not adding PDi Store agent to build)
endif

# Root at your own risk
ifeq ($(ROOTED_BUILD_NEEDED), T)
$(warning Adding root package outside branch, do not publicly distribute)
   PRODUCT_PACKAGES += su \
                       Superuser
endif

# WIDEVINE support requires a number of dedicated libraries and apps to be added
ifeq ($(WIDEVINE_SUPPORT),T)
$(warning Adding Widevine packages)
   PRODUCT_PACKAGES += com.google.widevine.software.drm.xml \
		       com.google.widevine.software.drm     \
		       libprotobuf-cpp-2.3.0-lite	    \
		       libwvlevel3			    \
		       libdrmwvmcommon			    \
		       libdrmwvmplugin                      \
		       libwvdrmengine			    \
		       libcdm_protos			    \
		       libwvm                               \
	               libWVStreamControlAPI_L3             \
		       libwvdrm_L3                          \
		       WidevineSamplePlayer                 \
		       libdrmdecrypt			    \
		       installkeybox			    \
		       install-file-key-box

   PRODUCT_PROPERTY_OVERRIDES += drm.service.enabled=true
endif 

#ARA builds support cinch demo setup
ifeq ($(ARA_BUILD),T)
$(warning Adding ARA packages and files)

    PRODUCT_COPY_FILES += \
       packages/apps/pdi_packages_apps/PDiCinchWidget/app/src/main/res/raw/pdi_cinch_widget_demo_pngs.config:/system/etc/pdi_cinch_widget_demo_pngs.config

endif

# MDM builds handle CCI on there own and do not contain wi-fi
# MDM builds run there own launcher like environment, support WIDEVINE, 
# and have an extra game   
ifneq ($(MDM_BUILD),T)
$(warning adding Wifi Widget)
    PRODUCT_PACKAGES += org.androidappdev.wifiwidget \
			cci-test \
			internalSpeakers
else
$(warning NOT adding Wifi Widget and cci-test)
$(warning adding journey apps and services)
   PRODUCT_PACKAGES += com.ihealthsuite.android.journey \
		       com.ihealth.suite.journey.CCIApplication \
		       libjni-cci.so \
                       com.Swank.SwankMediaPlayer \
		       com.kmagic.solitaire_450
endif   

# Builds needing SOTI support require an extra package
ifeq ($(SOTI_SUPPORT),T)
   PRODUCT_PACKAGES += net.mobicontrol.pdi.shared
endif

# AT builds are single user
ifeq ($(AT_BUILD),T)
$(warning not an AT build, adding multiuser packages)
   PRODUCT_PACKAGES += com.pdiarm.newuserconfirmation \
                       com.teslacoilsw.launcher
endif

PRODUCT_PROPERTY_OVERRIDES += hw.nobattery=true
PRODUCT_PROPERTY_OVERRIDES += sys.device.type=tablet
