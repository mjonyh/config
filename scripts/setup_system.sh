# scripts/setup_system.sh
# System preferences and configuration

SETUP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Helpers ---
if ! command -v log_info &> /dev/null; then
    BLUE='\033[0;34m'
    NC='\033[0m'
    log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
fi

# --- Global Setup ---
setup_common() {
    log_info "Performing common system setup..."
    
    # Change shell to Zsh
    if [ "$SHELL" != "$(which zsh)" ] && [ -n "$(which zsh)" ]; then
        log_info "Changing default shell to zsh..."
        
        # On Linux, chsh might require password. On macOS, dscl or chsh.
        # Try standard chsh first
        if [[ "$(uname)" == "Darwin" ]]; then
             sudo dscl . -create "/Users/$USER" UserShell "$(which zsh)"
        else
             chsh -s "$(which zsh)"
        fi
    fi
    
    # Create hushlogin to silence login banner
    touch ~/.hushlogin
    
    # Git Config
    setup_git
}

setup_git() {
    log_info "Configuring Git..."
    git config --global user.name "mjonyh"
    git config --global user.email "mjonyh@gmail.com"
    
    # Credential helper
    if [[ "$(uname)" == "Darwin" ]]; then
        git config --global credential.helper osxkeychain
    else
        git config --global credential.helper store
    fi
}

setup_ssh() {
    log_info "Checking SSH configuration..."
    if [ ! -f ~/.ssh/id_rsa ]; then
        log_info "Creating SSH key (id_rsa)..."
        ssh-keygen -t rsa -b 4096 -C "mjonyh@gmail.com" -f ~/.ssh/id_rsa -N ""
        
        log_info "Is this a new machine? You need to add this public key to GitHub:"
        cat ~/.ssh/id_rsa.pub
        
        if [[ "$(uname)" == "Darwin" ]]; then
             open https://github.com/settings/ssh
        elif command -v xdg-open &> /dev/null; then
             xdg-open https://github.com/settings/ssh
        fi
        
        echo "Press enter once you have added the key..."
        read
    else
        log_info "SSH key exists."
    fi
}

# --- macOS Specific ---
setup_macos() {
    setup_common
    setup_ssh
    
    log_info "Setting macOS defaults..."
    # Add any specific 'defaults write' commands here if needed
    
    # Probhat Layout
    log_info "Installing Probhat keyboard layout..."
    curl -fsSL https://raw.githubusercontent.com/mdminhazulhaque/probhat-osx/master/install.sh | sudo bash
}

# --- Linux Specific ---
setup_linux() {
    setup_common
    setup_ssh
    
    log_info "Setting Linux defaults..."
    # Nothing specific currently besides common shell
}
