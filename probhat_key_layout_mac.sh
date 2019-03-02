#!/bin/sh

cd /Library/Keyboard\ Layouts
sudo rm -f Probhat.keylayout
sudo rm -f Probhat.icns
sudo curl -O# https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/Probhat.keylayout
sudo curl -O# https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/Probhat.icns

cd
