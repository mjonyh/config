#!/bin/bash

# Use fzf to select a directory or enter a new one.
# It searches up to 3 levels deep in your home directory, ignoring common clutter.
TARGET_DIR=$( (find ~ -maxdepth 3 -type d -not -path '*/\.*' -not -path '*/Library/*' -not -path '*/node_modules/*') | fzf --prompt="Select or Create Directory: " )

# Exit if fzf was cancelled (e.g., by pressing Esc).
if [ -z "$TARGET_DIR" ]; then
    echo "No directory selected."
    exit 0
fi

# If the selected path is not a directory, ask to create it.
if [ ! -d "$TARGET_DIR" ]; then
    read -p "Directory not found. Create '$TARGET_DIR'? [y/N] " -n 1 -r
    echo # Move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p "$TARGET_DIR"
    else
        echo "Aborted."
        exit 1
    fi
fi

# Change to the target directory.
cd "$TARGET_DIR" || exit

# Create a sanitized session name from the directory's basename.
# This replaces characters that tmux doesn't like (e.g., '.') with underscores.
SESSION_NAME=$(basename "$TARGET_DIR" | tr . _)

# If not currently in a tmux session, create a new one or attach to an existing one.
if [ -z "$TMUX" ]; then
    tmux new-session -A -s "$SESSION_NAME"
else
    # If already in tmux, create the new session (if it doesn't exist) but don't attach.
    if ! tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
        tmux new-session -d -s "$SESSION_NAME"
    fi
    # Switch the client to the target session.
    tmux switch-client -t "$SESSION_NAME"
fi
