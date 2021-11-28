#!/bin/sh
rm -fr kernel-release-3.10
unzip kernel-release-3.10.zip
cd kernel-release-3.10
ARCH=arm scripts/kconfig/merge_config.sh \
    arch/arm/configs/rockchip_defconfig \
    android/configs/android-base.cfg \
    android/configs/android-recommended.cfg
sed -ie '/# CONFIG_MODULES is not set/a CONFIG_MODULES=y\
CONFIG_MODULE_UNLOAD=y' .config
sed -ie '/# CONFIG_BT_HCIBTUSB is not set/a CONFIG_BT_HCIBTUSB=m' .config
ARCH=arm make olddefconfig
