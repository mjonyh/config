#!/bin/bash

# Ensure the notes directory exists
NOTES_DIR="$HOME/git/markdown/notes"
mkdir -p "$NOTES_DIR"

# Generate the filename based on the current date
FILE_NAME="research.md"
noteFilename="$NOTES_DIR/$FILE_NAME"

# Ensure the file exists
# touch "$noteFilename"

if [ ! -f $noteFilename ]; then
  echo "# Notes for $(date +%Y-%m-%d)" > $noteFilename
fi

nvim -c "norm Go" \
  -c "norm Go## $(date +%H:%M)" \
  -c "norm G2o" \
  -c "norm zz" \
  -c "startinsert" $noteFilename

# # Launch a new Kitty terminal
# kitty --detach bash -c "
#     tmux new-session -d -s notes_session && \
#     tmux send-keys 'nvim +startinsert $FILE_PATH' C-m && \
#     tmux attach-session -t notes_session
# "

