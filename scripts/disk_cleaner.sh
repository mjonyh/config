#!/bin/bash

# Disk Space Analyzer and Cleaner for macOS
echo "Starting disk space analysis..."

# Function to analyze directory sizes
analyze_disk_usage() {
    echo "=== Disk Space Analysis Report ==="
    echo "1. Overall disk usage:"
    df -h /
    
    echo -e "\n2. Large directories in home folder:"
    du -h -d 1 ~/ | sort -hr | head -10
    
    echo -e "\n3. Checking common cache locations:"
    for dir in "~/Library/Caches" "~/.cache" "~/Library/Containers"; do
        if [ -d "$dir" ]; then
            size=$(du -sh "$dir" 2>/dev/null | cut -f1)
            echo "   $dir: $size"
        fi
    done
}

# Function for safe cleanup
safe_cleanup() {
    echo -e "\n=== Safe Cleanup Options ==="
    
    # Homebrew cache cleanup (if Homebrew is installed)
    if command -v brew &> /dev/null; then
        read -p "Clean Homebrew cache? (y/n): " answer
        if [ "$answer" = "y" ]; then
            echo "Cleaning Homebrew cache..."
            brew cleanup --prune=all
        fi
    fi
    
    # User cache cleanup
    read -p "Clean user caches? (This will remove cache files from ~/Library/Caches/) (y/n): " answer
    if [ "$answer" = "y" ]; then
        echo "Cleaning user caches..."
        rm -rf ~/Library/Caches/*
    fi
    
    # Docker, Xcode, and other development cache cleanup
    if [ -d ~/Library/Developer/Xcode/DerivedData ]; then
        read -p "Clean Xcode DerivedData? (y/n): " answer
        if [ "$answer" = "y" ]; then
            echo "Cleaning Xcode DerivedData..."
            rm -rf ~/Library/Developer/Xcode/DerivedData/*
        fi
    fi
}

# Main execution
analyze_disk_usage
safe_cleanup

echo -e "\nCleanup completed! Recommended: Restart your computer after cleanup."
