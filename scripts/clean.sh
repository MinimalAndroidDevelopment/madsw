#!/bin/bash
set -e

APPNAME="madsw"
DOMAIN="com/github/MinimalAndroidDevelopment"

echo "-------> Cleaning build directory"
rm -rf build/*
rm -rf classes.dex
rm -rf src/$DOMAIN/$APPNAME/R.java
