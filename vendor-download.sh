#!/bin/sh
Bluedroid=master
System=nougat-release
wget -O libbt-usb-master.zip \
    https://github.com/liangxiaoju/libbt-usb/archive/refs/heads/master.zip
wget -O bluedroid.tar.gz \
    https://android.googlesource.com/platform/external/bluetooth/bluedroid/+archive/refs/heads/${Bluedroid}.tar.gz
wget -O utils.tar.gz \
    https://android.googlesource.com/platform/system/core/+archive/refs/heads/${System}/include/utils.tar.gz
wget -O cutils.tar.gz \
    https://android.googlesource.com/platform/system/core/+archive/refs/heads/${System}/include/cutils.tar.gz
wget -O log.tar.gz \
    https://android.googlesource.com/platform/system/core/+archive/refs/heads/${System}/include/log.tar.gz


