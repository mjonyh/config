#!/bin/bash

# Check if zoxide is installed
if ! command -v zoxide &> /dev/null; then
    echo "zoxide is not installed. Please install it first."
    exit 1
fi

# Get the target directory using zoxide
target_dir=$(zoxide query "$1")

# If the directory is not found, exit
if [ -z "$target_dir" ]; then
    echo "Directory not found with zoxide. Please check your input."
    exit 1
fi

# Extract the name of the directory to use as the tmux session name
session_name=$(basename "$target_dir")

# Change to the target directory
cd "$target_dir" || exit

# Check if a tmux session with the same name already exists
if tmux has-session -t "$session_name" 2>/dev/null; then
    # Attach to the existing session
    tmux attach-session -t "$session_name"
else
    # Create a new tmux session
    tmux new-session -s "$session_name"
fi

