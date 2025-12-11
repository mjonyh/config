#!/bin/bash

# install.sh
# Master installation script for mjonyh's dotfiles

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/common_utils.sh"
source "$SCRIPT_DIR/scripts/install_packages.sh"
source "$SCRIPT_DIR/scripts/setup_system.sh"

show_help() {
    cat << EOF
Usage: ./install.sh [OPTIONS]

Options:
    --install-packages   Install system packages only
    --setup-system       Run system setup (defaults, shell, git) only
    --symlink-only       Run symlink configuration only
    --all                Run full installation (default)
    --help               Show this help message
EOF
}

main() {
    local mode="all"
    
    if [[ $# -gt 0 ]]; then
        case "$1" in
            --install-packages) mode="packages" ;;
            --setup-system) mode="setup" ;;
            --symlink-only) mode="symlink" ;;
            --all) mode="all" ;;
            --help) show_help; exit 0 ;;
            *) log_error "Unknown option: $1"; show_help; exit 1 ;;
        esac
    fi
    
    log_info "Starting installation script (Mode: $mode)..."
    
    # 1. Install Packages
    if [[ "$mode" == "all" ]] || [[ "$mode" == "packages" ]]; then
        if [[ "$(uname)" == "Darwin" ]]; then
            install_packages_macos
        elif [[ -f /etc/arch-release ]]; then
            install_packages_arch
        elif [[ -f /etc/debian_version ]]; then
             log_warning "Debian/Ubuntu detected - basic support only."
             # Call a debian function if it existed, or just warn
        else
            log_warning "Unsupported OS for package installation."
        fi
    fi
    
    # 2. System Setup
    if [[ "$mode" == "all" ]] || [[ "$mode" == "setup" ]]; then
        if [[ "$(uname)" == "Darwin" ]]; then
            setup_macos
        else
            setup_linux
        fi
    fi
    
    # 3. Symlinks
    if [[ "$mode" == "all" ]] || [[ "$mode" == "symlink" ]] || [[ "$mode" == "packages" ]]; then # usually packages also implies checking configs
         log_info "Running symlink manager..."
         "$SCRIPT_DIR/symlink-config.sh" install
    fi
    
    log_success "Installation complete!"
    log_info "You may need to restart your shell."
}

main "$@"
