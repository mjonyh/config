#!/bin/bash

# Fix Neovim Symlink Script
# This script properly creates the nvim symlink that should have been created by symlink-configs.sh

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DATE=$(date +"%Y%m%d_%H%M%S")

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

# Main function to fix nvim symlink
fix_nvim_symlink() {
    echo -e "${GREEN}🔧 Neovim Symlink Fix${NC}"
    echo "====================="
    echo ""
    
    local source="$SCRIPT_DIR/nvim"
    local target="$HOME/.config/nvim"
    local backup_dir="$HOME/.config-backups/nvim_fix_$BACKUP_DATE"
    
    # Check if source exists
    if [[ ! -d "$source" ]]; then
        log_error "Source nvim directory not found: $source"
        exit 1
    fi
    
    log_info "Source: $source"
    log_info "Target: $target"
    echo ""
    
    # Check current status
    if [[ -L "$target" ]]; then
        local current_link=$(readlink "$target")
        if [[ "$current_link" == "$source" ]]; then
            log_success "Nvim is already correctly symlinked!"
            log_info "Current link: $target -> $current_link"
            return 0
        else
            log_warning "Nvim is symlinked to wrong location: $current_link"
            log_info "Will update to point to: $source"
        fi
    elif [[ -e "$target" ]]; then
        log_warning "Nvim config exists as regular directory/file"
        log_info "Will backup and replace with symlink"
    else
        log_info "No existing nvim config found"
    fi
    
    # Create backup directory
    mkdir -p "$backup_dir"
    
    # Backup existing config if it exists
    if [[ -e "$target" ]]; then
        log_info "Backing up existing config..."
        cp -r "$target" "$backup_dir/"
        log_success "Backup created: $backup_dir/$(basename "$target")"
        
        # Remove existing file/directory/symlink
        rm -rf "$target"
        log_info "Removed existing config"
    fi
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"
    
    # Create symlink
    ln -sf "$source" "$target"
    
    # Verify symlink
    if [[ -L "$target" ]] && [[ "$(readlink "$target")" == "$source" ]]; then
        log_success "Symlink created successfully!"
        log_info "✅ $target -> $source"
        echo ""
        
        # Show contents
        log_info "Nvim config contents:"
        ls -la "$target/" | head -5
        echo ""
        
        log_success "🎉 Neovim configuration is now properly symlinked!"
        echo ""
        echo -e "${BLUE}Next steps:${NC}"
        echo "1. Open nvim to test the configuration"
        echo "2. All LSP plugins will auto-install on first run"
        echo "3. Any changes to $source will be immediately active"
        echo ""
        if [[ -d "$backup_dir" ]]; then
            echo -e "${YELLOW}Backup location:${NC} $backup_dir"
        fi
    else
        log_error "Failed to create symlink"
        exit 1
    fi
}

# Run the fix
fix_nvim_symlink