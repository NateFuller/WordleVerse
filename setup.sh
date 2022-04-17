#!/bin/bash

# pod install

# Adds necessary environment variables (such as Ad Mob App ID) to path 
source ./Scripts/add_env_keys.sh

# Take those keys from the path and add them to our app's Info.plist
./Scripts/ReadEnvironmentVariables.swift