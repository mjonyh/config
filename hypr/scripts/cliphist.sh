#!/bin/bash
# Clipboard history script using cliphist and wofi

if [[ "$1" == "c" ]]; then
    cliphist list | wofi --dmenu | cliphist decode | wl-copy
else
    cliphist list | wofi --dmenu | cliphist decode | wl-copy
fi
