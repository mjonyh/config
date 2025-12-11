# scripts/install_packages.sh
# Functions to install packages depending on the OS

# Detect directory of this script
PKG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$PKG_DIR/common_utils.sh" 2>/dev/null || true # Source logging if available, or define below

# --- Helpers ---
if ! command -v log_info &> /dev/null; then
    BLUE='\033[0;34m'
    NC='\033[0m'
    log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
    log_warning() { echo -e "\033[1;33m[WARNING]\033[0m $1"; }
    log_error() { echo -e "\033[0;31m[ERROR]\033[0m $1"; }
fi

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- macOS (Homebrew) ---
install_packages_macos() {
    log_info "Starting macOS package installation..."

    # Install Homebrew
    if ! command_exists brew; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        log_info "Homebrew already installed."
    fi

    log_info "Updating Homebrew..."
    brew update

    # Core Brew Packages
    local brew_packages=(
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
        "neovim"
        "zsh"
        "fzf"
        "ripgrep"
        "fd"
        "bat"
        "eza" # exa is unmaintained, eza is the successor
        "starship"
        "zoxide"
    )

    for pkg in "${brew_packages[@]}"; do
        if brew list --formula | grep -q "^${pkg}$"; then
             log_info "$pkg is already installed."
        else
             log_info "Installing $pkg..."
             brew install "$pkg"
        fi
    done

    # Cask Applications
    local cask_apps=(
        "iterm2"
        "rectangle"
        "cmake"
        # Add others from original script if needed
    )

    for app in "${cask_apps[@]}"; do
        log_info "Installing Cask: $app..."
        brew install --cask "$app" || log_warning "Failed to install cask $app"
    done
    
    # Python Support
    install_python_packages
}

# --- Arch Linux (Pacman + Yay) ---
install_packages_arch() {
    log_info "Starting Arch Linux package installation..."

    # System update
    log_info "Updating system..."
    sudo pacman -Syu --noconfirm

    # Core Packages
    local pacman_packages=(
        "git"
        "tmux"
        "wget"
        "tree"
        "neovim"
        "zsh"
        "base-devel"
        "nodejs"
        "npm"
        "python"
        "python-pip"
        "htop"
        "fzf"
        "ripgrep"
        "fd"
        "bat"
        "eza" # replace exa
        "man-db"
        "openssh"
        "zoxide"
        "starship"
        "unzip"
    )

    for pkg in "${pacman_packages[@]}"; do
        if pacman -Qi "$pkg" &> /dev/null; then
            log_info "$pkg is already installed."
        else
            log_info "Installing $pkg..."
            sudo pacman -S --noconfirm "$pkg"
        fi
    done

    # AUR Helper (yay)
    if ! command_exists yay; then
        log_info "Installing yay..."
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd -
    fi

    # AUR Packages
    local aur_packages=(
        "nerd-fonts-hack"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "atuin"
    )

    for pkg in "${aur_packages[@]}"; do
        if pacman -Qi "$pkg" &> /dev/null; then
             log_info "$pkg is already installed."
        else
             log_info "Installing AUR package: $pkg..."
             yay -S --noconfirm "$pkg"
        fi
    done

    # Python Support
    install_python_packages
}

# --- Shared Python Packages ---
install_python_packages() {
    log_info "Installing Python packages..."
    local py_packages=(
        "numpy"
        "scipy"
        "matplotlib"
        "unidecode"
        "tmuxp"
        "pynvim"
    )
    
    # Check if pip break system packages is needed (PEP 668)
    local pip_args=""
    if [[ -f /usr/lib/python3.11/EXTERNALLY-MANAGED ]] || [[ -f /usr/lib/python3.12/EXTERNALLY-MANAGED ]]; then
         pip_args="--break-system-packages"
    fi

    for pkg in "${py_packages[@]}"; do
        log_info "Installing pip package: $pkg..."
        # Try installing user-locally to avoid permission issues
        pip3 install --user $pip_args "$pkg" || log_warning "Failed to install $pkg"
    done
}

# --- Main Entry Point Wrapper (if called directly) ---
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        install_packages_macos
    elif [[ -f /etc/arch-release ]]; then
        install_packages_arch
    else
        log_warning "Unsupported OS for this script direct execution. Use install.sh wrapper."
    fi
fi
