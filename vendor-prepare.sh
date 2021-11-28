#!/bin/sh
rm -fr libbt-usb-master
# Распаковка libbt-usb-master.zip
unzip libbt-usb-master.zip
mkdir jni
mv libbt-usb-master/* jni/
mv jni libbt-usb-master/
# Создание Android.mk
cat <<EOT >libbt-usb-master/jni/Application.mk
APP_PLATFORM := android-21
APP_ABI := armeabi-v7a
EOT
# Установка libcutils.so из ТВ-приставки: /system/lib/libcutils.so
mkdir libbt-usb-master/jni/lib
cp libcutils.so libbt-usb-master/jni/lib
cat <<EOT >>libbt-usb-master/jni/Android.mk
include \$(CLEAR_VARS)
LOCAL_MODULE := libcutils
LOCAL_SRC_FILES := lib/libcutils.so
include \$(PREBUILT_SHARED_LIBRARY)
EOT
# Распаковка подсистемы журналирования.
mkdir libbt-usb-master/jni/include/log
tar -C libbt-usb-master/jni/include/log -zxf log.tar.gz
# Распаковка пакета utils.
mkdir libbt-usb-master/jni/include/utils
tar -C libbt-usb-master/jni/include/utils -zxf utils.tar.gz
# Распаковка пакета cutils.
mkdir libbt-usb-master/jni/include/cutils
tar -C libbt-usb-master/jni/include/cutils \
    -zxf cutils.tar.gz
# Распаковка подсистемы Bluedroid.
mkdir -p libbt-usb-master/external/bluetooth/bluedroid
tar -C libbt-usb-master/external/bluetooth/bluedroid \
    -zxf bluedroid.tar.gz
# Генерирование vnd_generic.txt -> vnd_buildcfg.h.
libbt-usb-master/external/bluetooth/bluedroid/tools/gen-buildcfg.sh \
    libbt-usb-master/jni/include/vnd_generic.txt \
    libbt-usb-master/jni/include/vnd_buildcfg.h
# Исправление ошибки в jni/src/conf.c: FILE type undefined.
sed -ie '/^#include <utils\/Log.h>/a #include <stdio.h>' \
    libbt-usb-master/jni/src/conf.c
# Исправление предупреждения в jni/src/bt_vendor_hci.c: memcpy inplicitly declared.
sed -ie '/^#include <utils\/Log.h>/a #include <string.h>' \
    libbt-usb-master/jni/src/bt_vendor_hci.c
# Исправление предупреждений в jni/src/upio.c: functions implicitly declared.
sed -ie '/^#include <utils\/Log.h>/a #include <string.h>\
#include <stdio.h>\
#include <unistd.h>'\
    libbt-usb-master/jni/src/upio.c
# Исправление предупреждений в jni/src/userial_vendor.c: close implicitly declared.
sed -ie '/^#include <utils\/Log.h>/a #include <unistd.h>' \
    libbt-usb-master/jni/src/userial_vendor.c
# Создание сценария сборки.
cd libbt-usb-master
cat <<EOT >build.sh
#!/bin/sh
../android-ndk-r16b/ndk-build
EOT
