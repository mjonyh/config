#!/bin/bash

# Set the directory to scan
TARGET_DIR="$HOME/Downloads"
TEMPFILE="/tmp/duplicate_checksums.$$"

echo "Finding true duplicate files by content in $TARGET_DIR..."

# Generate checksums for all files
find "$TARGET_DIR" -type f -exec shasum {} \; | sort > "$TEMPFILE"

# Process duplicates
cat "$TEMPFILE" | awk '{print $1}' | sort | uniq -d | while read -r hash; do
    echo "Found duplicate files with hash: $hash"
    # Get all files with this hash
    files=$(grep "$hash" "$TEMPFILE" | cut -d' ' -f3-)
    
    # Keep the newest file (by modification time)
    newest_file=$(ls -t $files | head -1)
    echo "Keeping newest: $newest_file"
    
    # Remove the older duplicates
    echo "$files" | grep -v "$newest_file" | while read -r old_file; do
        echo "Removing duplicate: $old_file"
        rm "$old_file"
    done
done

# Clean up
rm -f "$TEMPFILE"

