#!/bin/bash

# symlink-config.sh - Advanced Configuration Symbolic Link Manager
# Creates symbolic links to config files with backup functionality and revert capability

# set -eo pipefail # Disabled to allow continuing on error with proper reporting

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config-backup"
LOG_FILE="$BACKUP_DIR/symlink.log"
UNDO_LOG="$BACKUP_DIR/undo.log"

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Initialize backup directory and logs
init_backup() {
    mkdir -p "$BACKUP_DIR"
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "# Symlink operations log - $(date)" > "$LOG_FILE"
    fi
    if [[ ! -f "$UNDO_LOG" ]]; then
        echo "# Undo operations log - $(date)" > "$UNDO_LOG"
    fi
}

# Create timestamped backup of existing file
backup_file() {
    local source_path="$1"
    local backup_name="$2"
    
    if [[ -f "$source_path" ]] || [[ -d "$source_path" ]]; then
        local timestamp=$(date '+%Y%m%d_%H%M%S')
        local backup_path="$BACKUP_DIR/${backup_name}.backup.${timestamp}"
        
        cp -r "$source_path" "$backup_path"
        echo "BACKUP:$(date):$source_path:$backup_path" >> "$LOG_FILE"
        print_success "Backed up existing file: $source_path -> $backup_path"
        
        # Store for undo capability
        echo "RESTORE:$source_path:$backup_path" >> "$UNDO_LOG"
        return 0
    fi
    return 1
}

# Create symbolic link
create_symlink() {
    local config_file="$1"
    local target_path="$2"
    local backup_name="$3"
    
    # Create target directory if it doesn't exist
    local target_dir=$(dirname "$target_path")
    mkdir -p "$target_dir"
    
    # Backup existing file/directory
    if backup_file "$target_path" "$backup_name"; then
        rm -rf "$target_path"
    fi
    
    # Create symbolic link
    ln -sf "$SCRIPT_DIR/$config_file" "$target_path"
    echo "SYMLINK:$(date):$SCRIPT_DIR/$config_file:$target_path" >> "$LOG_FILE"
    print_success "Created symlink: $target_path -> $SCRIPT_DIR/$config_file"
    
    # Store for undo capability  
    echo "REMOVE:$target_path" >> "$UNDO_LOG"
}

# Revert all changes made by this script
revert_changes() {
    print_info "Reverting all symlink changes..."
    
    if [[ ! -f "$UNDO_LOG" ]]; then
        print_error "No undo log found. Cannot revert changes."
        return 1
    fi
    
    local reverted_count=0
    
    # Process undo log in reverse order
    tac "$UNDO_LOG" | while IFS=':' read -r action path backup_path; do
        case "$action" in
            "REMOVE")
                if [[ -L "$path" ]]; then
                    rm "$path"
                    print_success "Removed symlink: $path"
                    ((reverted_count++))
                fi
                ;;
            "RESTORE")
                if [[ -f "$backup_path" ]] || [[ -d "$backup_path" ]]; then
                    rm -rf "$path" 2>/dev/null || true
                    cp -r "$backup_path" "$path"
                    print_success "Restored original: $path"
                    ((reverted_count++))
                fi
                ;;
        esac
    done
    
    # Clear undo log after successful revert
    > "$UNDO_LOG"
    print_success "Reverted $reverted_count changes. Undo log cleared."
}

# Show current symlink status
show_status() {
    print_info "Current symbolic link status:"
    
    # Config mappings (source_file:target_path)
    local configs=(
        "zshrc:$HOME/.zshrc"
        "vimrc:$HOME/.vimrc"
        "tmux.conf:$HOME/.tmux.conf"
        "starship.toml:$HOME/.config/starship.toml"
        "nvim:$HOME/.config/nvim"
        "ghostty:$HOME/.config/ghostty"
        "hypr:$HOME/.config/hypr"
        "config/wofi:$HOME/.config/wofi"
    )
    
    for config_pair in "${configs[@]}"; do
        local config_file="${config_pair%%:*}"
        local target_path="${config_pair##*:}"
        
        if [[ -L "$target_path" ]]; then
            local link_target=$(readlink "$target_path")
            if [[ "$link_target" == "$SCRIPT_DIR/$config_file" ]]; then
                print_success "$config_file -> $target_path (✓ linked)"
            else
                print_warning "$config_file -> $target_path (⚠ linked to different location: $link_target)"
            fi
        elif [[ -f "$target_path" ]] || [[ -d "$target_path" ]]; then
            print_warning "$config_file -> $target_path (⚠ file exists, not linked)"
        else
            print_info "$config_file -> $target_path (➖ not found)"
        fi
    done
}

# Main function to create all symlinks
create_symlinks() {
    print_info "Creating symbolic links for configuration files..."
    
    # Initialize backup system
    init_backup
    
    # Config mappings (source_file:target_path)
    local configs=(
        "zshrc:$HOME/.zshrc"
        "vimrc:$HOME/.vimrc"
        "tmux.conf:$HOME/.tmux.conf"
        "starship.toml:$HOME/.config/starship.toml"
        "nvim:$HOME/.config/nvim"
        "ghostty:$HOME/.config/ghostty"
        "hypr:$HOME/.config/hypr"
        "config/wofi:$HOME/.config/wofi"
        "termite:$HOME/.config/termite"
        "rc.lua.awesome:$HOME/.config/awesome/rc.lua"
    )
    
    local success_count=0
    local total_count=${#configs[@]}
    
    for config_pair in "${configs[@]}"; do
        local config_file="${config_pair%%:*}"
        local target_path="${config_pair##*:}"
        local backup_name=$(basename "$target_path")
        
        # Check if source exists before attempting to link
        if [[ -f "$SCRIPT_DIR/$config_file" ]] || [[ -d "$SCRIPT_DIR/$config_file" ]]; then
            # Special handling for deep directories like awesome/rc.lua
            mkdir -p "$(dirname "$target_path")"
            
            create_symlink "$config_file" "$target_path" "$backup_name"
            ((success_count++))
        else
            print_warning "Config source not found, skipping: $SCRIPT_DIR/$config_file"
        fi
    done
    
    print_success "Successfully created $success_count/$total_count symbolic links"
    print_info "Backup directory: $BACKUP_DIR"
    print_info "Log file: $LOG_FILE"
}

# Show help
show_help() {
    cat << EOF
Usage: $0 [OPTION]

Advanced Configuration Symbolic Link Manager

OPTIONS:
    install, -i     Create symbolic links for all config files
    revert, -r      Revert all changes made by this script
    status, -s      Show current symlink status
    help, -h        Show this help message

EXAMPLES:
    $0 install      # Create all symlinks with backup
    $0 revert       # Restore original files and remove symlinks
    $0 status       # Check current status

FEATURES:
    • Automatic backup of existing config files
    • Timestamped backups in ~/.config-backup/
    • Complete undo/revert capability
    • Status checking for all managed configs
    • Safe overwrite protection

EOF
}

# Main script logic
main() {
    case "${1:-help}" in
        "install" | "-i")
            create_symlinks
            ;;
        "revert" | "-r")
            revert_changes
            ;;
        "status" | "-s") 
            show_status
            ;;
        "help" | "-h" | *)
            show_help
            ;;
    esac
}

# Check if script is being run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi