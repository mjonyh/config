#!/bin/bash

# This script detects the operating system and prints the current Wi-Fi SSID.

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS command
  SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep -w 'SSID' | awk '{print $2}')
  echo $SSID
elif [[ "$(uname)" == "Linux" ]]; then
  # Linux command
  SSID=$(iwgetid -r)
  echo $SSID
fi
