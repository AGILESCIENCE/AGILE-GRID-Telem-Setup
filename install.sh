#!/usr/bin/env bash

trap exit ERR

if [ "$1" == "-j" ] ; then
    parallel=$1
fi

### check environment variables
if [ -z "$AGILE" ] || [ -z $(env | grep "AGILE=") ] ; then
    echo "AGILE environment variable not set. Abort."
    exit
fi
if [ -z "$CFITSIO" ] || [ -z $(env | grep "CFITSIO=") ] ; then
    echo "CFITSIO environment variable not set. Abort."
    exit
fi
if [ -z "$ROOTSYS" ] || [ -z $(env | grep "ROOTSYS=") ] ; then
    echo "ROOTSYS environment variable not set. Abort."
    exit
fi

if [ "$1" == "clean" ] ; then
    cd PacketLib
    make clean
    cd libQLBase
    make clean
    cd libagiletelem
    make clean
    exit
fi

echo "install PacketLib"
cd PacketLib
make install prefix=$AGILE
cd ..

echo "install libQLBase"
cd libQLBase
cmake CMakeLists.txt -DCMAKE_INSTALL_PREFIX=$AGILE
make install
cd ..

echo "install agiletelem"
cd libagiletelem
make ${parallel} install prefix=$AGILE
cd ..

echo "install agilesci2"
cd agilesci2
make ${parallel} install prefix=$AGILE
cd ..

echo "install gtImporterELtelem"
cd gtImporterELtelem
make ${parallel} install prefix=$AGILE
cd ..

#if [ -z "$OPENCV" ] || [ -z $(env | grep "OPENCV=") ] ; then
#    	echo "OPENCV environment variable not set. AG_extspot not installed."
#else
#	echo "install AG_extspot"
#	cd agextspot-v2
#	make ${parallel} install prefix=$AGILE
#	cd ..
#fi
