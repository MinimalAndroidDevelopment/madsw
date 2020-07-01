#!/bin/bash

echo "-------> Generating signed key"
keytool -genkeypair -validity 365 -keystore assets/key/mykey.keystore -keyalg RSA -keysize 2048
