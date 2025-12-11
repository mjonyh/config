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

# Check if running with sudo (install should be run as normal user)
if [ "$EUID" -eq 0 ]; then 
    log_error "Please do not run this script with sudo"
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages via pacman
install_pacman_packages() {
    local packages=(
        "git"
        "tmux"
        "wget"
        "tree"
        "neovim"
        "zsh"
        "base-devel"
        "nodejs"
        "python"
        "python-pip"
        "htop"
        "fzf"
        "ripgrep"
        "fd"
        "bat"
        "exa"
        "man-db"
        "openssh"
    )
    
    log_info "Updating package database..."
    sudo pacman -Syu || {
        log_error "Failed to update package database"
        exit 1
    }
    
    for package in "${packages[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            log_info "$package is already installed"
        else
            log_info "Installing $package..."
            sudo pacman -S --noconfirm "$package" || log_warning "Failed to install $package"
        fi
    done
}

# Function to install AUR helper (yay)
install_aur_helper() {
    if ! command_exists yay; then
        log_info "Installing yay AUR helper..."
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        if [ $? -ne 0 ]; then
            log_error "Failed to install yay"
            exit 1
        fi
        log_success "yay installed successfully"
    else
        log_info "yay is already installed"
    fi
}

# Function to install AUR packages
install_aur_packages() {
    local packages=(
        "nerd-fonts-hack"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "atuin"
        "starship"
    )
    
    for package in "${packages[@]}"; do
        log_info "Installing AUR package: $package..."
        yay -S --noconfirm "$package" || log_warning "Failed to install $package"
    done
}

# Function to install Python packages
install_python_packages() {
    local packages=(
        "numpy"
        "scipy"
        "matplotlib"
        "unidecode"
        "tmuxp"
        "pynvim"
    )
    
    for package in "${packages[@]}"; do
        log_info "Installing Python package: $package..."
        pip install --user "$package" || log_warning "Failed to install $package"
    done
}

# Function to setup Git configuration
setup_git() {
    log_info "Setting up Git configuration..."
    git config --global user.name "mjonyh"
    git config --global user.email "mjonyh@gmail.com"
    
    # Add SSH key to SSH agent
    if [ -f ~/.ssh/id_rsa ]; then
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_rsa
    else
        log_warning "SSH key not found at ~/.ssh/id_rsa"
    fi
}

# Function to setup SSH key
setup_ssh() {
    if [ ! -f ~/.ssh/id_rsa ]; then
        log_info "Creating SSH key..."
        ssh-keygen -t rsa -b 4096 -C "mjonyh@gmail.com"
        
        log_info "Please add this public key to Github"
        log_info "Your public key:"
        cat ~/.ssh/id_rsa.pub
        log_info "Opening https://github.com/settings/ssh"
        xdg-open https://github.com/settings/ssh
        read -p "Press [Enter] key after adding the SSH key to Github..."
    else
        log_info "SSH key already exists"
    fi
}

# Function to setup Linux preferences
setup_linux_preferences() {
    log_info "Setting up Linux preferences..."
    
    # Disable last login message
    touch ~/.hushlogin
    
    # Set default shell to zsh
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        chsh -s "$(which zsh)"
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        
        # Enable plugins
        log_info "Enabling Oh My Zsh plugins..."
        sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
    else
        log_info "Oh My Zsh is already installed"
    fi
}

# Function to install Starship prompt
install_starship() {
    if ! command_exists starship; then
        log_info "Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sh
    else
        log_info "Starship is already installed"
    fi
    
    # Create config directory if it doesn't exist
    mkdir -p ~/.config
    
    # Link starship config
    if [ -f ~/.dotfiles/starship.toml ]; then
        log_info "Linking Starship config..."
        ln -sf ~/.dotfiles/starship.toml ~/.config/starship.toml
    fi
}

# Main installation process
main() {
    log_info "Starting Arch Linux setup..."
    
    # Install packages
    install_pacman_packages
    install_aur_helper
    install_aur_packages
    install_python_packages
    
    # Setup Git and SSH
    setup_ssh
    setup_git
    
    # Setup Linux preferences
    setup_linux_preferences
    
    # Install Oh My Zsh
    install_oh_my_zsh
    
    # Install Starship prompt
    install_starship
    
    # Install dotfiles
    log_info "Installing dotfiles..."
    cd ~
    if [ ! -d "$HOME/.dotfiles" ]; then
        git clone https://github.com/mjonyh/config.git ~/.dotfiles
    fi
    sh ~/.dotfiles/symdotfiles.sh
    
    log_success "Setup completed successfully!"
    log_info "Please log out and log back in to apply all changes."
}

# Run main function
main