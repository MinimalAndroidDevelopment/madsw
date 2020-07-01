#!/bin/bash

APPNAME="madsw"
DOTDOMAIN="com.github.MinimalAndroidDevelopment"
ADB="/mnt/D/software/linux/IDE/android/sdk/platform-tools/adb"

echo "-------> Launching emulator"
$ADB install -r build/$APPNAME.apk
$ADB shell am start -n $DOTDOMAIN.$APPNAME/$DOTDOMAIN.$APPNAME.MainActivity
