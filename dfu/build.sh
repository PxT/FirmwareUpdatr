#!/bin/sh
# Builds a copy of dfu-programmer suitable for bundling within the Platypus-built firmware app

BUILD_DIR="`dirname \"$0\"`"
if [ "$BUILD_DIR" == "." ]
then
	BUILD_DIR="`pwd`"
fi

cd src

cd libusb-1.0.8
./configure --prefix="$BUILD_DIR"
make
make install
make clean
cd ..
cd libusb-compat-0.1.3
./configure --prefix="$BUILD_DIR" LIBUSB_1_0_CFLAGS=-I"$BUILD_DIR/include/libusb-1.0" LIBUSB_1_0_LIBS=-L"$BUILD_DIR/lib -lusb-1.0"
make
make install
make clean
cd ..
cd dfu-programmer
./configure --prefix="$BUILD_DIR" LIBUSB_1_0_CFLAGS=-I"$BUILD_DIR"/include/libusb-1.0 LIBUSB_1_0_LIBS=-L"$BUILD_DIR/lib -lusb-1.0"
make
make install
make clean
cd ..

cd ..
