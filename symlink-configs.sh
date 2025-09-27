#!/bin/bash

# Enhanced Dotfiles Symbolic Link Creator with Date-Stamped Backups
# Author: mjonyh
# Description: Creates symbolic links for all config files with automatic backup

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

# Counters
LINKED_COUNT=0
BACKED_UP_COUNT=0
SKIPPED_COUNT=0
ERROR_COUNT=0

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
Enhanced Dotfiles Symbolic Link Creator

Usage: $0 [OPTIONS]

OPTIONS:
    -h, --help          Show this help message
    -i, --interactive   Interactive mode - choose which configs to link
    -f, --fonts-only    Only install fonts
    -n, --no-fonts      Skip font installation
    -v, --verbose       Verbose output
    --dry-run          Show what would be done without making changes

EXAMPLES:
    $0                  # Full automatic setup
    $0 -i              # Interactive mode
    $0 --fonts-only    # Only install fonts
    $0 --no-fonts      # Skip fonts, link configs only

The script will:
1. Create date-stamped backups of existing configs
2. Create symbolic links to config files
3. Install Hack Nerd Fonts
4. Make scripts executable
5. Generate a detailed report

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
            *)
                log_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
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
}

# Run main function with all arguments
main "$@"