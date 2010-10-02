#!/bin/sh

# CreateDiskImage.sh
# Electric2D
#
# Created by Robert on 03/06/2009.
# Copyright 2009 Electric TopHat Ltd. All rights reserved.

set -x

# Determine the project name and version
#VERS=$(agvtool mvers -terse1)
#VERS=1.0
VERS=`pl < $SOURCE_ROOT/Electric3D-Info.plist | grep CFBundleVersion | sed -e 's/.*= "//' -e 's/";//'`

libName="libElectric3D"
sdkName="Electric3D"

IPHONE_SDK=3.2
IPHONE_SDK_DEPLOYMENT=3.2
IPHONESIM_SDK=3.2

PROJECT_HEADERS_PATH=$SOURCE_ROOT/Classes/Electric3D

# Derived names
VOLNAME=${PROJECT}_${VERS}
DISK_IMAGE=$BUILD_DIR/$VOLNAME
DISK_IMAGE_FILE=$BUILD_DIR/$VOLNAME.dmg
PUBLIC_HEADERS_FOLDER_PATH=usr/local/include

# Remove old targets
rm -rf $DISK_IMAGE
rm -f $DISK_IMAGE_FILE
test -d $DISK_IMAGE && chmod -R +w $DISK_IMAGE && rm -rf $DISK_IMAGE
mkdir -p $DISK_IMAGE

##############################################
# Remeber you need to mark the header files 
# in the Copy Headers to Public if you want 
# them copied...
##############################################

##############################################
# iPhone Target Build
##############################################
# Create the iPhone SDK directly in the disk image folder.

# Build the Release Version
xcodebuild -target $libName -configuration Release -sdk iphoneos$IPHONE_SDK install \
   ARCHS="armv6 armv7" SKIP_INSTALL=NO\
   DSTROOT=$DISK_IMAGE/SDKs/$sdkName/iphoneos.sdk || exit 2
sed -e "s/%PROJECT%/$PROJECT/g" \
    -e "s/%VERS%/$VERS/g" \
    -e "s/%IPHONE_SDK%/$IPHONE_SDK/g" \
	-e "s/%IPHONE_SDK_DEPLOYMENT%/$IPHONE_SDK_DEPLOYMENT/g" \
    $SOURCE_ROOT/Resources/iphoneos.sdk/SDKSettings.plist > $DISK_IMAGE/SDKs/$sdkName/iphoneos.sdk/SDKSettings.plist || exit 3
   
# Build the Debug Version
xcodebuild -target $libName -configuration Debug -sdk iphoneos$IPHONE_SDK install \
   ARCHS="armv6 armv7" SKIP_INSTALL=NO\
   DSTROOT=$DISK_IMAGE/SDKs/${sdkName}_d/iphoneos.sdk || exit 4   
sed -e "s/%PROJECT%/$PROJECT/g" \
    -e "s/%VERS%/$VERS/g" \
    -e "s/%IPHONE_SDK%/$IPHONE_SDK/g" \
	-e "s/%IPHONE_SDK_DEPLOYMENT%/$IPHONE_SDK_DEPLOYMENT/g" \
    $SOURCE_ROOT/Resources/iphoneos.sdk/SDKSettings.plist > $DISK_IMAGE/SDKs/${sdkName}_d/iphoneos.sdk/SDKSettings.plist || exit 5
	
##############################################

##############################################
# iPhone Simulator Target Build
##############################################

# Release Target
xcodebuild -target $libName -configuration Release -sdk iphonesimulator$IPHONESIM_SDK install \
    ARCHS=i386 SKIP_INSTALL=NO\
    DSTROOT=$DISK_IMAGE/SDKs/$sdkName/iphonesimulator.sdk || exit 6
sed -e "s/%PROJECT%/$PROJECT/g" \
    -e "s/%VERS%/$VERS/g" \
    -e "s/%IPHONESIM_SDK%/$IPHONESIM_SDK/g" \
    $SOURCE_ROOT/Resources/iphonesimulator.sdk/SDKSettings.plist > $DISK_IMAGE/SDKs/$sdkName/iphonesimulator.sdk/SDKSettings.plist || exit 7

# Debug Target
xcodebuild -target $libName -configuration Debug -sdk iphonesimulator$IPHONESIM_SDK install \
    ARCHS=i386 SKIP_INSTALL=NO\
    DSTROOT=$DISK_IMAGE/SDKs/${sdkName}_d/iphonesimulator.sdk || exit 8
sed -e "s/%PROJECT%/$PROJECT/g" \
    -e "s/%VERS%/$VERS/g" \
    -e "s/%IPHONESIM_SDK%/$IPHONESIM_SDK/g" \
    $SOURCE_ROOT/Resources/iphonesimulator.sdk/SDKSettings.plist > $DISK_IMAGE/SDKs/${sdkName}_d/iphonesimulator.sdk/SDKSettings.plist || exit 9

##############################################

##############################################
# Copy the source verbatim into the disk image sdks.
##############################################

# Include this code if we need to retain the header file layout

#mkdir -p $DISK_IMAGE/SDKs/$sdkName/iphoneos.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#mkdir -p $DISK_IMAGE/SDKs/$sdkName/iphonesimulator.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#mkdir -p $DISK_IMAGE/SDKs/$sdkName_d/iphoneos.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#mkdir -p $DISK_IMAGE/SDKs/$sdkName_d/iphonesimulator.sdk/$PUBLIC_HEADERS_FOLDER_PATH

#cp -p -R $PROJECT_HEADERS_PATH $DISK_IMAGE/SDKs/$sdkName/iphoneos.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#cp -p -R $PROJECT_HEADERS_PATH $DISK_IMAGE/SDKs/$sdkName/iphonesimulator.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#cp -p -R $PROJECT_HEADERS_PATH $DISK_IMAGE/SDKs/$sdkName_d/iphoneos.sdk/$PUBLIC_HEADERS_FOLDER_PATH
#cp -p -R $PROJECT_HEADERS_PATH $DISK_IMAGE/SDKs/$sdkName_d/iphonesimulator.sdk/$PUBLIC_HEADERS_FOLDER_PATH

# remove the file's that are not needed
#rm -r `find $DISK_IMAGE/SDKs/ -type d -name .svn`
#rm -r `find $DISK_IMAGE/SDKs/ -type f -name \*.txt`
#rm -r `find $DISK_IMAGE/SDKs/ -type f -name \*.m`
#rm -r `find $DISK_IMAGE/SDKs/ -type f -name \*.mm`
#rm -r `find $DISK_IMAGE/SDKs/ -type f -name \*.c`
#rm -r `find $DISK_IMAGE/SDKs/ -type f -name \*.cpp`

##############################################

##############################################
# Copy the source verbatim into the disk image.
##############################################

mkdir -p $DISK_IMAGE/Source

cp -p -R $PROJECT_HEADERS_PATH $DISK_IMAGE/Source/

# remove the file's that are not needed
rm -r `find $DISK_IMAGE/Source -type d -name .svn`

##############################################

##############################################
# Copy the Documentation
##############################################

cp -p -R $SOURCE_ROOT/Documents/* $DISK_IMAGE

##############################################

##############################################
# Copy the Samples
##############################################

mkdir -p $DISK_IMAGE/Samples/Source
cp -p -R $SOURCE_ROOT/Classes/Test/* $DISK_IMAGE/Samples/Source

mkdir -p $DISK_IMAGE/Samples/Data
cp -p -R $SOURCE_ROOT/Data/* $DISK_IMAGE/Samples/Data

##############################################

##############################################
# Write out the disk image 
##############################################

hdiutil create -volname $VOLNAME -srcfolder $DISK_IMAGE $DISK_IMAGE_FILE

##############################################

##############################################
# remove the old folder
##############################################

#rm -r $DISK_IMAGE

##############################################

