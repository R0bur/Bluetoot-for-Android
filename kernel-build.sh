#!/bin/sh
cd kernel-release-3.10
PATH=$HOME/tvbox/gcc-linaro-4.9.4-2017.01-x86_64_arm-eabi/bin:$PATH \
ARCH=arm CROSS_COMPILE=arm-eabi- make modules
