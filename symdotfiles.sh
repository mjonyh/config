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

# Backup function
backup_file() {
    local file=$1
    if [ -f "$file" ] || [ -d "$file" ]; then
        local backup="${file}.bak"
        log_info "Backing up $file to $backup"
        mv "$file" "$backup" || {
            log_error "Failed to backup $file"
            return 1
        }
    fi
}

# Create symbolic link with backup
create_symlink() {
    local source=$1
    local target=$2
    if [ ! -e "$source" ]; then
        log_error "Source file $source does not exist"
        return 1
    fi
    backup_file "$target"
    ln -sf "$source" "$target" && log_success "Created symlink: $target -> $source"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install NERD fonts
install_nerd_fonts() {
    log_info "Please install NERD fonts from https://nerdfonts.com"
    log_info "After installation, configure the font in your terminal"
    read -p "Press [Enter] to continue..."
}

# Setup dotfiles
setup_dotfiles() {
    local dotfiles_dir="$HOME/.dotfiles"
    if [ ! -d "$dotfiles_dir" ]; then
        log_info "Cloning dotfiles repository..."
        git clone https://github.com/mjonyh/config.git "$dotfiles_dir" || {
            log_error "Failed to clone dotfiles repository"
            return 1
        }
    else
        log_warning "Dotfiles directory already exists"
    fi
}

# Setup Vim
setup_vim() {
    local vim_bundle="$HOME/.vim/bundle"
    mkdir -p "$vim_bundle"
    
    # Install Vundle if not present
    if [ ! -d "$vim_bundle/Vundle.vim" ]; then
        log_info "Installing Vundle..."
        git clone https://github.com/VundleVim/Vundle.vim.git "$vim_bundle/Vundle.vim" || {
            log_error "Failed to install Vundle"
            return 1
        }
    fi
    
    # Setup vimrc
    create_symlink "$HOME/.dotfiles/vimrc" "$HOME/.vimrc"
    
    # Install plugins
    log_info "Installing Vim plugins..."
    vim +PluginInstall +qall
    
    # Install YouCompleteMe
    if [ -d "$vim_bundle/youcompleteme" ]; then
        log_info "Installing YouCompleteMe..."
        cd "$vim_bundle/youcompleteme" && ./install.sh
    fi
}

# Setup Tmux
setup_tmux() {
    local tmux_plugins="$HOME/.tmux/plugins"
    mkdir -p "$tmux_plugins"
    
    # Install TPM if not present
    if [ ! -d "$tmux_plugins/tpm" ]; then
        log_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$tmux_plugins/tpm" || {
            log_error "Failed to install TPM"
            return 1
        }
    fi
    
    # Setup tmux.conf
    create_symlink "$HOME/.dotfiles/tmux.conf" "$HOME/.tmux.conf"
    
    # Install plugins
    log_info "Installing Tmux plugins..."
    tmux start-server
    tmux new-session -d
    "$tmux_plugins/tpm/scripts/install_plugins.sh"
    tmux kill-server
}

# Setup Neovim
setup_neovim() {
    local nvim_config="$HOME/.config/nvim"
    mkdir -p "$nvim_config"
    
    log_info "Setting up Neovim configuration..."
    cp "$HOME/.dotfiles/nvim/init.vim" "$nvim_config/init.vim" || {
        log_error "Failed to copy Neovim configuration"
        return 1
    }
}

# Main installation process
main() {
    log_info "Starting dotfiles installation..."
    
    install_nerd_fonts
    setup_dotfiles
    
    # Setup tmuxp
    create_symlink "$HOME/.dotfiles/tmuxp" "$HOME/.tmuxp"
    
    # Setup zshrc
    create_symlink "$HOME/.dotfiles/zshrc" "$HOME/.zshrc"
    
    setup_vim
    setup_tmux
    setup_neovim
    
    log_success "Installation completed successfully!"
    log_info "Please restart your terminal to apply all changes."
}

# Run main function
main

