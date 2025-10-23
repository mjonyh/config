#!/bin/bash

# This script cleans up system and user caches, logs, and other temporary files
# to free up storage space on your Mac.

# --- IMPORTANT ---
# Some commands require administrator privileges.
# Run this script with sudo for full effect: sudo ./clean_mac.sh

while getopts ":n" opt; do
  case ${opt} in
    n )
      CLEAN_NODE_MODULES=true
      ;;
    \? )
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

echo "Starting Mac cleanup script..."

# --- Cache Cleaning ---

echo "Cleaning user caches..."
rm -rf ~/Library/Caches/* 2>/dev/null
echo "User caches cleaned."

echo "Cleaning system caches..."
# This command requires sudo
if [ "$(id -u)" = "0" ]; then
  # Some files may be protected by System Integrity Protection (SIP) and cannot be deleted.
  # These 'Operation not permitted' errors are expected and can be safely ignored.
  rm -rf /Library/Caches/* 2>/dev/null
  echo "System caches cleaned."
else
  echo "Skipping system cache cleaning. Run with sudo to clean system caches."
fi

# --- Log Cleaning ---

echo "Cleaning system logs..."
# This command requires sudo
if [ "$(id -u)" = "0" ]; then
  rm -rf /private/var/log/* 2>/dev/null
  echo "System logs cleaned."
else
  echo "Skipping system log cleaning. Run with sudo to clean system logs."
fi

# --- Homebrew Cleanup (if installed) ---

if command -v brew &> /dev/null; then
  echo "Cleaning up Homebrew..."
brew cleanup -s && brew autoremove
  echo "Homebrew cleanup complete."
else
  echo "Homebrew not found, skipping."
fi

# --- Docker Cleanup (if installed) ---

if command -v docker &> /dev/null; then
  echo "Cleaning up Docker..."
  docker system prune -a -f
  echo "Docker cleanup complete."
else
  echo "Docker not found, skipping."
fi

# --- NPM Cleanup (if installed) ---

if command -v npm &> /dev/null; then
  echo "Cleaning up npm cache..."
  npm cache clean --force
  echo "npm cache cleanup complete."
else
  echo "npm not found, skipping."
fi

if [ "$CLEAN_NODE_MODULES" = true ]; then
  find_and_delete_node_modules
fi

# --- Interactive Node Modules Cleanup ---

find_and_delete_node_modules() {
  echo "Finding node_modules folders..."
  # Find all node_modules folders, and print their size and path
  find . -name "node_modules" -type d -prune | while read -r dir; do
    size=$(du -sh "$dir" | cut -f1)
    echo "Found: $dir (Size: $size)"
    read -p "Delete this folder? (y/N) " choice
    case "$choice" in
      y|Y )
        rm -rf "$dir"
        echo "Deleted $dir"
        ;;
      * )
        echo "Skipping $dir"
        ;;
    esac
  done
}

echo "Mac cleanup script finished."
