#!/bin/bash

ARCH=$(uname -i)
source /etc/os-release

if [[ ! -e "../travellingCamera/daemon/lib/$ARCH/$VERSION_CODENAME" ]]; then
  mkdir -p ../travellingCamera/daemon/lib/$ARCH/$VERSION_CODENAME
fi

mkdir bld
cd bld
cmake -DBUILD_GSTREAMER_PLUGIN=ON -DBUILD_JNI=OFF -DBUILD_DEPENDENCIES=ON ..
cd bld
make -j3
if [[ "$?" == "0" ]]; then
  cp ./dependency/libkvscproducer/kvscproducer-src/libcproducer.so ../../travellingCamera/daemon/lib/$ARCH/$VERSION_CODENAME/
  cp ./libKinesisVideoProducer.so ../../travellingCamera/daemon/lib/$ARCH/$VERSION_CODENAME/
  cp ./libgstkvssink.so ../../travellingCamera/daemon/lib/$ARCH/$VERSION_CODENAME/
fi

