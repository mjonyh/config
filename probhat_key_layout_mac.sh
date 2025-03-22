#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then 
    log_error "Please run this script with sudo"
    exit 1
fi

# Define paths
KEYBOARD_LAYOUTS="/Library/Keyboard Layouts"
PROBHAT_KEYLAYOUT="$KEYBOARD_LAYOUTS/Probhat.keylayout"
PROBHAT_ICNS="$KEYBOARD_LAYOUTS/Probhat.icns"
REPO_URL="https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master"

# Check if Keyboard Layouts directory exists
if [ ! -d "$KEYBOARD_LAYOUTS" ]; then
    log_error "Keyboard Layouts directory not found at $KEYBOARD_LAYOUTS"
    exit 1
fi

# Backup existing files if they exist
backup_file() {
    local file=$1
    if [ -f "$file" ]; then
        local backup="${file}.bak"
        log_info "Backing up $file to $backup"
        mv "$file" "$backup" || {
            log_error "Failed to backup $file"
            return 1
        }
    fi
}

# Download file with error handling
download_file() {
    local url=$1
    local output=$2
    log_info "Downloading $url to $output"
    curl -sSL "$url" -o "$output" || {
        log_error "Failed to download $url"
        return 1
    }
}

# Main installation process
main() {
    log_info "Starting Probhat keyboard layout installation..."
    
    # Backup existing files
    backup_file "$PROBHAT_KEYLAYOUT"
    backup_file "$PROBHAT_ICNS"
    
    # Download new files
    cd "$KEYBOARD_LAYOUTS" || {
        log_error "Failed to change directory to $KEYBOARD_LAYOUTS"
        exit 1
    }
    
    download_file "$REPO_URL/Probhat.keylayout" "Probhat.keylayout" || exit 1
    download_file "$REPO_URL/Probhat.icns" "Probhat.icns" || exit 1
    
    # Set proper permissions
    chmod 644 "Probhat.keylayout" "Probhat.icns"
    
    log_success "Probhat keyboard layout installed successfully!"
    log_info "Please log out and log back in for the changes to take effect."
}

# Run main function
main
