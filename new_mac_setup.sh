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
if [ "$EUID" -eq 0 ]; then 
    log_error "Please do not run this script with sudo"
    exit 1
fi

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Homebrew if not present
install_homebrew() {
    if ! command_exists brew; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ $? -ne 0 ]; then
            log_error "Failed to install Homebrew"
            exit 1
        fi
        log_success "Homebrew installed successfully"
    else
        log_info "Homebrew is already installed"
    fi
}

# Function to install packages via Homebrew
install_brew_packages() {
    local packages=(
        "git"
        "tmux"
        "git-extras"
        "legit"
        "git-flow"
        "tree"
        "wget"
        "trash"
        "svn"
        "mackup"
        "node"
        "vim"
        "zsh"
        "neovim"
    )
    
    for package in "${packages[@]}"; do
        log_info "Installing $package..."
        brew install "$package" || log_warning "Failed to install $package"
    done
}

# Function to install Python packages
install_python_packages() {
    local packages=(
        "numpy"
        "scipy"
        "matplotlib"
        "django"
        "pymysql"
        "cryptography"
        "unidecode"
        "tmuxp"
        "pynvim"
        "bibcure"
    )
    
    for package in "${packages[@]}"; do
        log_info "Installing Python package: $package..."
        pip3 install "$package" || log_warning "Failed to install $package"
    done
}

# Function to install Cask applications
install_cask_applications() {
    local applications=(
        "iterm2"
        "spectacle"
        "cmake"
        # "google-chrome"
    )
    
    for app in "${applications[@]}"; do
        log_info "Installing $app..."
        brew install --cask "$app" || log_warning "Failed to install $app"
    done
}

# Function to setup Git configuration
setup_git() {
    log_info "Setting up Git configuration..."
    git config --global user.name "mjonyh"
    git config --global user.email "mjonyh@gmail.com"
    
    # Add SSH key to SSH agent
    if [ -f ~/.ssh/id_rsa ]; then
        ssh-add -K ~/.ssh/id_rsa
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
        log_info "Opening https://github.com/settings/ssh"
        open https://github.com/settings/ssh
        read -p "Press [Enter] key after adding the SSH key to Github..."
    else
        log_info "SSH key already exists"
    fi
}

# Function to setup macOS preferences
setup_macos_preferences() {
    log_info "Setting up macOS preferences..."
    
    # Disable last login message
    touch ~/.hushlogin
    
    # Set default shell to zsh
    if [ "$SHELL" != "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        sudo dscl . -create "/Users/$USER" UserShell "$(which zsh)"
    fi
}

# Function to install Probhat keyboard layout
install_probhat_keyboard() {
    log_info "Installing Probhat keyboard layout..."
    curl https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/install.sh | sudo bash
    log_info "To configure Probhat keyboard layout, visit: https://github.com/mdminhazulhaque/probhat-osx"
}

# Main installation process
main() {
    log_info "Starting macOS setup..."
    
    # Install Xcode Command Line Tools
    log_info "Installing Xcode Command Line Tools..."
    xcode-select --install
    
    # Install Homebrew and packages
    install_homebrew
    log_info "Updating Homebrew..."
    brew update
    
    # Install packages
    install_brew_packages
    install_python_packages
    install_cask_applications
    
    # Setup Git and SSH
    setup_ssh
    setup_git
    
    # Setup macOS preferences
    setup_macos_preferences
    
    # Install Probhat keyboard layout
    install_probhat_keyboard
    
    # Install dotfiles
    log_info "Installing dotfiles..."
    cd ~
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/symdotfiles.sh)"
    
    # Cleanup
    log_info "Cleaning up..."
    brew cleanup
    brew update
    brew upgrade
    brew cleanup
    
    log_success "Setup completed successfully!"
    log_info "Please restart your computer to apply all changes."
}

# Run main function
main

