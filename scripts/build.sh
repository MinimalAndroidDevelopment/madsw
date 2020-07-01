#!/bin/bash
set -e

APPNAME="madsw"
DOMAIN="com/github/MinimalAndroidDevelopment"
DOTDOMAIN="com.github.MinimalAndroidDevelopment"

BUILDTOOLSVER="28.0.3" # 30.0.0
PLATFORMVER="android-28"
SDKPATH="/mnt/D/software/linux/IDE/android/sdk/"
AAPT=$SDKPATH"build-tools/"$BUILDTOOLSVER"/aapt"
AAPT2=$SDKPATH"build-tools/"$BUILDTOOLSVER"/aapt2"
ANDJAR=$SDKPATH"platforms/"$PLATFORMVER"/android.jar"
DX=$SDKPATH"build-tools/"$BUILDTOOLSVER"/dx"
D8=$SDKPATH"build-tools/"$BUILDTOOLSVER"/d8"
APKSIGNER=$SDKPATH"build-tools/"$BUILDTOOLSVER"/apksigner"
ZIPALIGN=$SDKPATH"build-tools/"$BUILDTOOLSVER"/zipalign"

echo "-------> Cleaning build directory"
rm -rf build/*
rm -rf src/$DOMAIN/$APPNAME/R.java

echo "-------> Create bin/obj/com directories"
mkdir build/bin build/obj build/com

echo "-------> aapt2"
$AAPT2 compile --dir libs/res-appcompat-1.1.0 -o libs/resources-appcompat-1.1.0.zip
$AAPT2 compile --dir libs/res-appcompat-resources-1.1.0 -o libs/resources-appcompat-resources-1.1.0.zip
$AAPT2 compile --dir libs/res-core-1.3.0 -o libs/resources-core-1.3.0.zip
$AAPT2 compile --dir libs/res-fragment-1.2.5 -o libs/resources-fragment-1.2.5.zip
$AAPT2 compile --dir libs/res-drawerlayout-1.1.0 -o libs/resources-drawerlayout-1.1.0.zip
$AAPT2 compile --dir res -o build/resources.zip
$AAPT2 link\
    -I $ANDJAR\
    --auto-add-overlay\
    -R libs/resources-appcompat-1.1.0.zip\
    -R libs/resources-appcompat-resources-1.1.0.zip\
    -R libs/resources-core-1.3.0.zip\
    -R libs/resources-fragment-1.2.5.zip\
    -R libs/resources-drawerlayout-1.1.0.zip\
    --manifest assets/AndroidManifest.xml\
    --java build\
    --extra-packages androidx.appcompat:androidx.appcompat.resources:androidx.core:androidx.fragment\
    -o build/$APPNAME.apk build/resources.zip

echo "-------> Remove generated *.zip files"
rm -f libs/resources-appcompat-1.1.0.zip\
    libs/resources-appcompat-resources-1.1.0.zip\
    libs/resources-core-1.3.0.zip\
    libs/resources-fragment-1.2.5.zip\
    libs/resources-drawerlayout-1.1.0.zip\
    build/resources.zip

for i in libs/*.jar; do
  libs="$libs:$i"
  dxlibs="$dxlibs $i"
  d8libs="$d8libs --classpath $i"
done
libs="${libs#:}"

echo "-------> Compiling *.java files with javac"
javac -bootclasspath $ANDJAR\
    -cp $libs\
    -sourcepath src:build $(find src build -type f -name '*.java')\
    -d build/obj
    #-source 1.7\
    #-target 1.7\

echo "-------> d8"
$D8 --release --classpath $ANDJAR $d8libs --output . $(find build/obj -type f) $dxlibs

echo "-------> Combine .dex and temp apk"
$AAPT add build/$APPNAME.apk classes.dex

echo "-------> Aligning and signing final apk"
$ZIPALIGN -f 4 build/$APPNAME.apk build/bin/$APPNAME.apk
$APKSIGNER sign --ks ./assets/key/mykey.keystore build/$APPNAME.apk
