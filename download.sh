#!/usr/bin/env bash
#First parameter: git username
#Second parameter: -t -> do not use tags

trap exit ERR

if [ "$2" != "-t" ] ; then
	echo "USE TAGS"
	TAG_PACKETLIB=v3.2.0
	TAG_QLBASE=
	TAG_TELEM=
	TAG_SCI2=
	TAG_GENERATOR=
fi

echo "--------------"
git clone https://$1@github.com/ASTRO-BO/PacketLib.git
cd PacketLib
if [ "$2" != "-t" ]; then
	git checkout $TAG_PACKETLIB
else
	git checkout $TAG_PACKETLIB
fi
cd ..

echo "--------------"
git clone https://$1@github.com/ASTRO-BO/libQLBase.git
cd libQLBase
if [ "$2" != "-t" ]; then
        git checkout $TAG_QLBASE
else
        echo "Use master version"
fi
cd ..

echo "--------------"
git clone https://$1@github.com/AGILESCIENCE/libagiletelem.git 
cd libagiletelem
if [ "$2" != "-t" ]; then
        git checkout $TAG_TELEM
else
        echo "Use master version"
fi
cd ..

echo "--------------"
git clone https://$1@github.com/AGILESCIENCE/agilesci2.git    
cd agilesci2
if [ "$2" != "-t" ]; then
        git checkout $TAG_SCI2
else
        echo "Use master version"
fi
cd ..


echo "--------------"
git clone https://$1@github.com/AGILESCIENCE/gtImporterELtelem.git
cd gtImporterELtelem
if [ "$2" != "-t" ]; then
        git checkout $TAG_GENERATOR
else
        echo "Use master version"
fi
cd ..
