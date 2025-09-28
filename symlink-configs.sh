#!/bin/bash

# Enhanced Dotfiles Symbolic Link Creator with Date-Stamped Backups & Revert
# Author: mjonyh
# Description: Creates symbolic links for all config files with automatic backup and revert capability

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly PURPLE='\033[0;35m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly BACKUP_DATE=$(date +"%Y%m%d_%H%M%S")
readonly BACKUP_DIR="$HOME/.config-backups/$BACKUP_DATE"
readonly LOG_FILE="$BACKUP_DIR/symlink.log"
readonly BACKUP_ROOT="$HOME/.config-backups"

# Counters
LINKED_COUNT=0
BACKED_UP_COUNT=0
SKIPPED_COUNT=0
ERROR_COUNT=0
REVERTED_COUNT=0

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1" | tee -a "$LOG_FILE"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1" | tee -a "$LOG_FILE"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

log_header() {
    echo -e "${PURPLE}[HEADER]${NC} $1" | tee -a "$LOG_FILE"
}

log_step() {
    echo -e "${CYAN}[STEP]${NC} $1" | tee -a "$LOG_FILE"
}

# Initialize backup directory and logging
init_backup() {
    mkdir -p "$BACKUP_DIR"
    echo "# Symlink Configuration Log - $(date)" > "$LOG_FILE"
    echo "# Script: $0" >> "$LOG_FILE"
    echo "# Source Directory: $SCRIPT_DIR" >> "$LOG_FILE"
    echo "# Backup Directory: $BACKUP_DIR" >> "$LOG_FILE"
    echo "" >> "$LOG_FILE"
    
    log_header "Enhanced Dotfiles Symbolic Link Creator"
    log_info "Backup directory created: $BACKUP_DIR"
    log_info "Log file: $LOG_FILE"
}

# Initialize revert logging
init_revert_log() {
    local revert_backup_dir="$1"
    local revert_log_file="$revert_backup_dir/revert.log"
    
    echo "# Symlink Revert Log - $(date)" > "$revert_log_file"
    echo "# Reverting from backup: $revert_backup_dir" >> "$revert_log_file"
    echo "# Script: $0" >> "$revert_log_file"
    echo "" >> "$revert_log_file"
    
    echo "$revert_log_file"
}

# Create backup of existing file/directory
backup_existing() {
    local target="$1"
    local backup_name="$2"
    
    if [[ -e "$target" ]] || [[ -L "$target" ]]; then
        local backup_path="$BACKUP_DIR/$backup_name"
        mkdir -p "$(dirname "$backup_path")"
        
        if [[ -L "$target" ]]; then
            log_info "Removing existing symlink: $target"
            rm "$target"
        else
            log_info "Backing up existing file: $target -> $backup_path"
            mv "$target" "$backup_path"
            ((BACKED_UP_COUNT++))
        fi
        return 0
    fi
    return 1
}

# Create symbolic link
create_symlink() {
    local source="$1"
    local target="$2"
    local description="$3"
    
    log_step "Processing: $description"
    
    # Check if source exists
    if [[ ! -e "$source" ]]; then
        log_error "Source does not exist: $source"
        ((ERROR_COUNT++))
        return 1
    fi
    
    # Create target directory if needed
    local target_dir=$(dirname "$target")
    if [[ ! -d "$target_dir" ]]; then
        log_info "Creating directory: $target_dir"
        mkdir -p "$target_dir"
    fi
    
    # Backup existing file
    local backup_name=$(echo "$target" | sed "s|$HOME/||" | sed 's|/|_|g')
    backup_existing "$target" "$backup_name"
    
    # Create symlink
    if ln -sf "$source" "$target"; then
        log_success "Created symlink: $target -> $source"
        ((LINKED_COUNT++))
        return 0
    else
        log_error "Failed to create symlink: $target -> $source"
        ((ERROR_COUNT++))
        return 1
    fi
}

# Skip if already linked correctly
check_existing_symlink() {
    local source="$1"
    local target="$2"
    
    if [[ -L "$target" ]]; then
        local current_target=$(readlink "$target")
        if [[ "$current_target" == "$source" ]]; then
            log_info "Symlink already correct: $target -> $source"
            ((SKIPPED_COUNT++))
            return 0
        fi
    fi
    return 1
}

# Configuration mappings
# Format: "source_file:target_location:description"
declare -a CONFIG_MAPPINGS=(
    # Shell configurations
    "$SCRIPT_DIR/zshrc:$HOME/.zshrc:ZSH configuration"
    "$SCRIPT_DIR/starship.toml:$HOME/.config/starship.toml:Starship prompt configuration"
    
    # Editor configurations  
    "$SCRIPT_DIR/vimrc:$HOME/.vimrc:Vim configuration"
    "$SCRIPT_DIR/nvim:$HOME/.config/nvim:Neovim configuration directory"
    
    # Terminal and multiplexer
    "$SCRIPT_DIR/tmux.conf:$HOME/.tmux.conf:Tmux configuration"
    "$SCRIPT_DIR/tmuxp:$HOME/.tmuxp:Tmux session templates"
    "$SCRIPT_DIR/ghostty:$HOME/.config/ghostty:Ghostty terminal configuration"
    "$SCRIPT_DIR/termite:$HOME/.config/termite:Termite terminal configuration"
    
    # Window managers
    "$SCRIPT_DIR/hypr:$HOME/.config/hypr:Hyprland configuration"
    "$SCRIPT_DIR/rc.lua.awesome:$HOME/.config/awesome/rc.lua:AwesomeWM configuration"
    
    # Applications
    "$SCRIPT_DIR/config/qutebrowser:$HOME/.config/qutebrowser:Qutebrowser configuration"
    
    # Scripts and utilities
    "$SCRIPT_DIR/scripts:$HOME/.local/bin/config-scripts:Custom utility scripts"
    "$SCRIPT_DIR/src:$HOME/.local/share/config-src:Source files and utilities"
)

# Platform-specific configurations
setup_platform_configs() {
    case "$(uname)" in
        "Darwin")
            log_header "Setting up macOS-specific configurations"
            # Add macOS specific configs here if needed
            ;;
        "Linux")
            log_header "Setting up Linux-specific configurations"
            # Linux configs are already in the main mappings
            ;;
        *)
            log_warning "Unknown platform: $(uname)"
            ;;
    esac
}

# Install fonts
install_fonts() {
    log_header "Setting up Hack Nerd Fonts"
    
    local font_source="$SCRIPT_DIR/Hack"
    
    if [[ ! -d "$font_source" ]]; then
        log_warning "Hack fonts directory not found: $font_source"
        return 1
    fi
    
    case "$(uname)" in
        "Darwin")
            local font_target="$HOME/Library/Fonts"
            mkdir -p "$font_target"
            
            for font in "$font_source"/*.ttf; do
                if [[ -f "$font" ]]; then
                    local font_name=$(basename "$font")
                    if [[ ! -f "$font_target/$font_name" ]]; then
                        log_info "Installing font: $font_name"
                        cp "$font" "$font_target/"
                    else
                        log_info "Font already installed: $font_name"
                    fi
                fi
            done
            ;;
        "Linux")
            local font_target="$HOME/.local/share/fonts"
            mkdir -p "$font_target"
            
            for font in "$font_source"/*.ttf; do
                if [[ -f "$font" ]]; then
                    local font_name=$(basename "$font")
                    if [[ ! -f "$font_target/$font_name" ]]; then
                        log_info "Installing font: $font_name"
                        cp "$font" "$font_target/"
                    else
                        log_info "Font already installed: $font_name"
                    fi
                fi
            done
            
            # Refresh font cache
            if command -v fc-cache >/dev/null 2>&1; then
                log_info "Refreshing font cache..."
                fc-cache -fv
            fi
            ;;
    esac
}

# Validate prerequisites
check_prerequisites() {
    log_header "Checking prerequisites"
    
    # Check if we're in the right directory
    if [[ ! -f "$SCRIPT_DIR/README.md" ]] || [[ ! -f "$SCRIPT_DIR/zshrc" ]]; then
        log_error "This script must be run from the config repository directory"
        log_error "Current directory: $SCRIPT_DIR"
        exit 1
    fi
    
    # Check required commands
    local required_commands=("ln" "mkdir" "mv" "cp" "date")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_error "Required command not found: $cmd"
            exit 1
        fi
    done
    
    log_success "Prerequisites check passed"
}

# Process all configuration mappings
process_configurations() {
    log_header "Processing configuration files"
    
    for mapping in "${CONFIG_MAPPINGS[@]}"; do
        IFS=':' read -r source target description <<< "$mapping"
        
        # Skip if already correctly linked
        if check_existing_symlink "$source" "$target"; then
            continue
        fi
        
        # Create symlink
        create_symlink "$source" "$target" "$description"
    done
    
    # Special handling for nvim directory symlinks
    handle_directory_symlinks
}

# Handle directory symlinks (special case for nvim, etc.)
handle_directory_symlinks() {
    log_step "Checking directory symlinks"
    
    # Check nvim configuration specifically
    local nvim_source="$SCRIPT_DIR/nvim"
    local nvim_target="$HOME/.config/nvim"
    
    if [[ -d "$nvim_source" ]]; then
        if [[ -L "$nvim_target" ]] && [[ "$(readlink "$nvim_target")" == "$nvim_source" ]]; then
            log_info "✅ Neovim config already correctly symlinked"
        elif [[ -e "$nvim_target" ]]; then
            log_warning "⚠️ Neovim config exists but is not properly symlinked"
            log_info "Run ./fix-nvim-symlink.sh to fix this issue"
        else
            log_info "Creating nvim config symlink..."
            mkdir -p "$(dirname "$nvim_target")"
            ln -sf "$nvim_source" "$nvim_target"
            log_success "✅ Created nvim config symlink"
        fi
    fi
}

# Setup additional utilities
setup_utilities() {
    log_header "Setting up additional utilities"
    
    # Make scripts executable
    if [[ -d "$SCRIPT_DIR/scripts" ]]; then
        log_info "Making scripts executable..."
        find "$SCRIPT_DIR/scripts" -type f -name "*.sh" -exec chmod +x {} \;
        find "$SCRIPT_DIR/scripts" -type f -name "*.py" -exec chmod +x {} \;
    fi
    
    # Make setup scripts executable
    local setup_scripts=("symdotfiles.sh" "new_mac_setup.sh" "new_arch_setup.sh" "nvim.sh")
    for script in "${setup_scripts[@]}"; do
        if [[ -f "$SCRIPT_DIR/$script" ]]; then
            chmod +x "$SCRIPT_DIR/$script"
            log_info "Made executable: $script"
        fi
    done
}

# Generate summary report
generate_report() {
    log_header "Summary Report"
    log_info "Configurations processed: ${#CONFIG_MAPPINGS[@]}"
    log_success "Symlinks created: $LINKED_COUNT"
    log_warning "Files backed up: $BACKED_UP_COUNT"
    log_info "Already correct: $SKIPPED_COUNT"
    
    if [[ $ERROR_COUNT -gt 0 ]]; then
        log_error "Errors encountered: $ERROR_COUNT"
    fi
    
    log_info "Backup directory: $BACKUP_DIR"
    log_info "Log file: $LOG_FILE"
    
    if [[ $BACKED_UP_COUNT -gt 0 ]]; then
        echo ""
        log_info "Backed up files can be found in: $BACKUP_DIR"
        log_info "To restore a backup: mv $BACKUP_DIR/filename \$HOME/original_location"
    fi
}

# ============================================================================
#                              REVERT FUNCTIONALITY
# ============================================================================

# List available backups
list_backups() {
    echo -e "${PURPLE}[HEADER]${NC} Available Backup Sessions"
    
    if [[ ! -d "$BACKUP_ROOT" ]]; then
        echo -e "${YELLOW}[WARNING]${NC} No backup directory found: $BACKUP_ROOT"
        return 1
    fi
    
    local backups=($(ls -1t "$BACKUP_ROOT" 2>/dev/null | head -10))
    
    if [[ ${#backups[@]} -eq 0 ]]; then
        echo -e "${YELLOW}[WARNING]${NC} No backups found in $BACKUP_ROOT"
        return 1
    fi
    
    echo ""
    echo "Available backup sessions (most recent first):"
    echo "=============================================="
    
    local count=1
    for backup in "${backups[@]}"; do
        local backup_path="$BACKUP_ROOT/$backup"
        if [[ -d "$backup_path" ]]; then
            local log_file="$backup_path/symlink.log"
            local file_count=$(find "$backup_path" -type f ! -name "*.log" 2>/dev/null | wc -l)
            local backup_size=$(du -sh "$backup_path" 2>/dev/null | cut -f1)
            
            echo -e "${CYAN}[$count]${NC} $backup"
            echo "    Files backed up: $file_count"
            echo "    Size: $backup_size"
            
            if [[ -f "$log_file" ]]; then
                local created_links=$(grep -c "Created symlink:" "$log_file" 2>/dev/null || echo "0")
                echo "    Symlinks created: $created_links"
            fi
            
            echo ""
            ((count++))
        fi
    done
    
    return 0
}

# Select backup interactively
select_backup_interactive() {
    list_backups || return 1
    
    local backups=($(ls -1t "$BACKUP_ROOT" 2>/dev/null | head -10))
    
    echo -e "${YELLOW}Select a backup to revert (1-${#backups[@]}) or 'q' to quit:${NC}"
    read -r selection
    
    if [[ "$selection" == "q" ]] || [[ "$selection" == "Q" ]]; then
        log_info "Revert cancelled by user"
        return 1
    fi
    
    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [[ "$selection" -lt 1 ]] || [[ "$selection" -gt ${#backups[@]} ]]; then
        log_error "Invalid selection: $selection"
        return 1
    fi
    
    local selected_backup="${backups[$((selection-1))]}"
    echo "$BACKUP_ROOT/$selected_backup"
}

# Get backup info and confirm
confirm_revert() {
    local backup_dir="$1"
    local backup_name=$(basename "$backup_dir")
    
    log_header "Revert Confirmation"
    log_info "Selected backup: $backup_name"
    log_info "Backup location: $backup_dir"
    
    # Show what will be reverted
    echo ""
    echo -e "${CYAN}Files that will be restored:${NC}"
    find "$backup_dir" -type f ! -name "*.log" | while read -r file; do
        local relative_path=$(echo "$file" | sed "s|$backup_dir/||")
        local target_path=$(echo "$relative_path" | sed 's|_|/|g' | sed "s|^|$HOME/|")
        echo "  $target_path"
    done
    
    echo ""
    echo -e "${YELLOW}This will:${NC}"
    echo "  1. Remove current symlinks created by this script"
    echo "  2. Restore your original configuration files"
    echo "  3. Remove installed fonts (optional)"
    echo ""
    echo -e "${RED}WARNING: This will overwrite current configurations!${NC}"
    echo ""
    
    read -p "Are you sure you want to proceed? [y/N]: " -n 1 -r
    echo
    
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Revert a single file
revert_file() {
    local backup_file="$1"
    local backup_dir="$2"
    local revert_log="$3"
    
    # Calculate original target path
    local relative_path=$(echo "$backup_file" | sed "s|$backup_dir/||")
    local target_path=$(echo "$relative_path" | sed 's|_|/|g' | sed "s|^|$HOME/|")
    
    log_step "Reverting: $target_path"
    
    # Remove current symlink if it exists and points to our configs
    if [[ -L "$target_path" ]]; then
        local link_target=$(readlink "$target_path")
        if [[ "$link_target" == "$SCRIPT_DIR"* ]]; then
            log_info "Removing symlink: $target_path"
            rm "$target_path"
            echo "Removed symlink: $target_path" >> "$revert_log"
        else
            log_warning "Symlink exists but doesn't point to our configs: $target_path -> $link_target"
            echo "Skipped non-script symlink: $target_path -> $link_target" >> "$revert_log"
        fi
    elif [[ -f "$target_path" ]] || [[ -d "$target_path" ]]; then
        log_warning "Target exists but is not a symlink: $target_path"
        read -p "Overwrite existing file/directory? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Skipping: $target_path"
            echo "Skipped (user choice): $target_path" >> "$revert_log"
            return 0
        fi
        rm -rf "$target_path"
    fi
    
    # Create target directory if needed
    local target_dir=$(dirname "$target_path")
    mkdir -p "$target_dir"
    
    # Restore backup
    if cp -r "$backup_file" "$target_path"; then
        log_success "Restored: $target_path"
        echo "Restored: $target_path" >> "$revert_log"
        ((REVERTED_COUNT++))
    else
        log_error "Failed to restore: $target_path"
        echo "Failed to restore: $target_path" >> "$revert_log"
        ((ERROR_COUNT++))
    fi
}

# Revert fonts
revert_fonts() {
    local revert_log="$1"
    
    log_header "Reverting Fonts"
    
    case "$(uname)" in
        "Darwin")
            local font_dir="$HOME/Library/Fonts"
            ;;
        "Linux")
            local font_dir="$HOME/.local/share/fonts"
            ;;
        *)
            log_warning "Unknown platform: $(uname), skipping font revert"
            return 0
            ;;
    esac
    
    echo "Remove installed Hack Nerd Fonts? [y/N]: "
    read -r -n 1
    echo
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        local fonts_removed=0
        for font in "$font_dir"/Hack*.ttf; do
            if [[ -f "$font" ]]; then
                log_info "Removing font: $(basename "$font")"
                rm "$font"
                echo "Removed font: $font" >> "$revert_log"
                ((fonts_removed++))
            fi
        done
        
        if [[ $fonts_removed -gt 0 ]]; then
            log_success "Removed $fonts_removed Hack Nerd Font files"
            
            # Refresh font cache on Linux
            if [[ "$(uname)" == "Linux" ]] && command -v fc-cache >/dev/null 2>&1; then
                log_info "Refreshing font cache..."
                fc-cache -fv
            fi
        else
            log_info "No Hack Nerd Font files found to remove"
        fi
    else
        log_info "Keeping installed fonts"
        echo "Kept fonts (user choice)" >> "$revert_log"
    fi
}

# Main revert function
revert_changes() {
    local backup_dir="$1"
    
    # Validate backup directory
    if [[ ! -d "$backup_dir" ]]; then
        log_error "Backup directory not found: $backup_dir"
        return 1
    fi
    
    # Initialize revert logging
    local revert_log=$(init_revert_log "$backup_dir")
    
    log_header "Starting Revert Process"
    log_info "Backup directory: $backup_dir"
    log_info "Revert log: $revert_log"
    
    # Reset counters for revert
    REVERTED_COUNT=0
    ERROR_COUNT=0
    
    # Process each backup file
    find "$backup_dir" -type f ! -name "*.log" | while read -r backup_file; do
        revert_file "$backup_file" "$backup_dir" "$revert_log"
    done
    
    # Handle fonts
    revert_fonts "$revert_log"
    
    # Generate revert report
    log_header "Revert Summary"
    log_success "Files reverted: $REVERTED_COUNT"
    
    if [[ $ERROR_COUNT -gt 0 ]]; then
        log_error "Errors encountered: $ERROR_COUNT"
    fi
    
    log_info "Revert log: $revert_log"
    log_success "Revert completed!"
    
    echo ""
    echo -e "${GREEN}Your original configurations have been restored.${NC}"
    echo -e "${BLUE}Revert details logged to: $revert_log${NC}"
}

# Post-installation instructions
show_next_steps() {
    log_header "Next Steps"
    echo ""
    echo "1. Restart your shell or run: source ~/.zshrc"
    echo "2. Install shell framework (if not already done):"
    echo "   - Oh My Zsh: sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    echo "3. Install Starship prompt: curl -sS https://starship.rs/install.sh | sh"
    echo "4. For Neovim: Open nvim and plugins will auto-install"
    echo "5. For Tmux: Press prefix + I to install plugins"
    echo ""
    echo "For full environment setup, run:"
    echo "  macOS: ./new_mac_setup.sh"
    echo "  Arch:  ./new_arch_setup.sh"
    echo ""
}

# Interactive mode for selective linking
interactive_mode() {
    log_header "Interactive Mode - Select configurations to link"
    
    for mapping in "${CONFIG_MAPPINGS[@]}"; do
        IFS=':' read -r source target description <<< "$mapping"
        
        echo ""
        echo -e "${CYAN}Configuration:${NC} $description"
        echo -e "${BLUE}Source:${NC} $source"
        echo -e "${BLUE}Target:${NC} $target"
        
        if check_existing_symlink "$source" "$target"; then
            echo -e "${GREEN}Status:${NC} Already correctly linked"
            continue
        fi
        
        if [[ -e "$target" ]] || [[ -L "$target" ]]; then
            echo -e "${YELLOW}Status:${NC} Target exists (will be backed up)"
        else
            echo -e "${GREEN}Status:${NC} Target available"
        fi
        
        read -p "Link this configuration? [Y/n]: " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            log_info "Skipping: $description"
            ((SKIPPED_COUNT++))
        else
            create_symlink "$source" "$target" "$description"
        fi
    done
}

# Help function
show_help() {
    cat << EOF
Enhanced Dotfiles Symbolic Link Creator with Revert Capability

Usage: $0 [OPTIONS]

SETUP OPTIONS:
    -h, --help          Show this help message
    -i, --interactive   Interactive mode - choose which configs to link
    -f, --fonts-only    Only install fonts
    -n, --no-fonts      Skip font installation
    -v, --verbose       Verbose output
    --dry-run          Show what would be done without making changes

REVERT OPTIONS:
    -r, --revert        Revert changes (interactive backup selection)
    -R, --revert-from   Revert from specific backup directory
    -l, --list-backups  List all available backups
    --revert-latest     Revert from the most recent backup

EXAMPLES:
    # Setup
    $0                  # Full automatic setup
    $0 -i              # Interactive mode
    $0 --fonts-only    # Only install fonts
    $0 --no-fonts      # Skip fonts, link configs only
    
    # Revert
    $0 -r              # Interactive revert (choose backup)
    $0 --revert-latest # Revert from most recent backup
    $0 -l              # List available backups
    $0 -R ~/.config-backups/20241228_143022  # Revert from specific backup

FEATURES:
The script will:
1. Create date-stamped backups of existing configs
2. Create symbolic links to config files
3. Install Hack Nerd Fonts
4. Make scripts executable
5. Generate a detailed report

REVERT FEATURES:
- Safe revert with confirmation prompts
- Only removes symlinks created by this script
- Restores original configurations from backups
- Optional font removal during revert
- Detailed revert logging

All backups are stored in: ~/.config-backups/YYYYMMDD_HHMMSS/
EOF
}

# Main function
main() {
    # Parse command line arguments
    local interactive=false
    local fonts_only=false
    local no_fonts=false
    local dry_run=false
    local revert_mode=false
    local revert_from=""
    local list_backups_only=false
    local revert_latest=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -i|--interactive)
                interactive=true
                shift
                ;;
            -f|--fonts-only)
                fonts_only=true
                shift
                ;;
            -n|--no-fonts)
                no_fonts=true
                shift
                ;;
            --dry-run)
                dry_run=true
                shift
                ;;
            -v|--verbose)
                set -x
                shift
                ;;
            -r|--revert)
                revert_mode=true
                shift
                ;;
            -R|--revert-from)
                revert_from="$2"
                shift 2
                ;;
            -l|--list-backups)
                list_backups_only=true
                shift
                ;;
            --revert-latest)
                revert_latest=true
                shift
                ;;
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Handle revert operations
    if [[ "$list_backups_only" == true ]]; then
        list_backups
        exit 0
    fi
    
    if [[ "$revert_latest" == true ]]; then
        if [[ ! -d "$BACKUP_ROOT" ]]; then
            log_error "No backup directory found: $BACKUP_ROOT"
            exit 1
        fi
        
        local latest_backup=$(ls -1t "$BACKUP_ROOT" 2>/dev/null | head -1)
        if [[ -z "$latest_backup" ]]; then
            log_error "No backups found"
            exit 1
        fi
        
        revert_from="$BACKUP_ROOT/$latest_backup"
        log_info "Using latest backup: $revert_from"
    fi
    
    if [[ "$revert_mode" == true ]] || [[ -n "$revert_from" ]]; then
        # Handle revert mode
        if [[ -n "$revert_from" ]]; then
            # Revert from specific backup
            if [[ ! -d "$revert_from" ]]; then
                log_error "Backup directory not found: $revert_from"
                exit 1
            fi
            
            if confirm_revert "$revert_from"; then
                revert_changes "$revert_from"
            else
                log_info "Revert cancelled by user"
            fi
        else
            # Interactive revert
            local selected_backup
            if selected_backup=$(select_backup_interactive); then
                if confirm_revert "$selected_backup"; then
                    revert_changes "$selected_backup"
                else
                    log_info "Revert cancelled by user"
                fi
            fi
        fi
        exit 0
    fi
    
    # Normal setup mode (existing code)
    # Initialize
    init_backup
    check_prerequisites
    
    # Handle special modes
    if [[ "$fonts_only" == true ]]; then
        install_fonts
        exit 0
    fi
    
    # Setup platform-specific configurations
    setup_platform_configs
    
    # Process configurations
    if [[ "$interactive" == true ]]; then
        interactive_mode
    else
        process_configurations
    fi
    
    # Install fonts (unless --no-fonts)
    if [[ "$no_fonts" != true ]]; then
        install_fonts
    fi
    
    # Setup utilities
    setup_utilities
    
    # Generate report and show next steps
    generate_report
    show_next_steps
    
    log_success "Dotfiles setup completed successfully!"
    echo ""
    echo -e "${CYAN}To revert these changes later, use:${NC}"
    echo "  $0 --revert"
}

# Run main function with all arguments
main "$@"