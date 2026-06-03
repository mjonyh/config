#!/bin/bash
# Clipboard history manager using cliphist + wofi
# Usage:
#   cliphist.sh       - browse history, select to copy
#   cliphist.sh c     - same as above (browse & copy)
#   cliphist.sh d     - browse history, select to delete
#   cliphist.sh w     - wipe all clipboard history

case "$1" in
    d)
        # Delete selected entry
        cliphist list | wofi --dmenu --prompt "Delete clipboard entry" | cliphist delete
        ;;
    w)
        # Wipe all history
        cliphist list | cliphist delete
        notify-send "Clipboard" "History wiped"
        ;;
    c|*)
        # Browse and copy (default)
        cliphist list | wofi --dmenu --prompt "Clipboard history" | cliphist decode | wl-copy
        ;;
esac
