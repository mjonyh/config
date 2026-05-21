#!/usr/bin/env bash
# scripts/setup_gpu.sh
# Install and configure NVIDIA 580xx driver stack + CUDA + OpenCL
# for Arch Linux systems with GTX 10xx (Pascal) GPUs.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_utils.sh" 2>/dev/null || true

# --- Fallback logging (matches repo style) ---
if ! command -v log_info &>/dev/null; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    NC='\033[0m'
    log_info()    { echo -e "${BLUE}[INFO]${NC}    $*"; }
    log_success() { echo -e "${GREEN}[OK]${NC}      $*"; }
    log_warning() { echo -e "${YELLOW}[WARNING]${NC} $*"; }
    log_error()   { echo -e "${RED}[ERROR]${NC}   $*"; }
fi

# --- Configuration ---
NVIDIA_PACKAGES=(
    nvidia-580xx-dkms
    nvidia-580xx-utils
    nvidia-580xx-settings
    nvidia-580xx-settings-debug
    linux-firmware-nvidia
)

OPENCL_PKG="opencl-nvidia"
CUDA_DIR="/home/mjonyh/cuda-12.3"
CUDA_SYMLINK="/usr/local/cuda"
CUDA_SYMLINK_VER="/usr/local/cuda-12.3"
CUDA_TOOLKIT_URL="https://developer.download.nvidia.com/compute/cuda/12.3.2/local_installers/cuda_12.3.2_545.23.08_linux.run"
CUDA_RUN_FILE="/tmp/cuda_12.3.2_linux.run"

IGNOREPKG_LINE="IgnorePkg   = nvidia-580xx-dkms nvidia-580xx-utils nvidia-580xx-settings nvidia-580xx-settings-debug ${OPENCL_PKG} linux-firmware-nvidia"

PACMAN_CONF="/etc/pacman.conf"

# --- Helpers ---
check_root() {
    if [[ $EUID -eq 0 ]]; then
        log_error "Do not run this script as root. It will use sudo when needed."
        exit 1
    fi
}

check_arch() {
    if [[ ! -f /etc/arch-release ]]; then
        log_error "This script is for Arch Linux only."
        exit 1
    fi
}

check_gpu() {
    if ! lspci | grep -qi nvidia; then
        log_error "No NVIDIA GPU detected."
        exit 1
    fi
    local gpu_name
    gpu_name=$(lspci | grep -i nvidia | head -1)
    log_info "Detected: $gpu_name"
}

pkg_installed() {
    pacman -Qi "$1" &>/dev/null
}

# --- Steps ---

step1_install_nvidia() {
    log_info "Step 1: Installing NVIDIA 580xx driver packages..."

    local to_install=()
    for pkg in "${NVIDIA_PACKAGES[@]}"; do
        if pkg_installed "$pkg"; then
            log_info "  $pkg already installed, skipping."
        else
            to_install+=("$pkg")
        fi
    done

    if [[ ${#to_install[@]} -gt 0 ]]; then
        sudo pacman -S --noconfirm --needed "${to_install[@]}"
        log_success "NVIDIA packages installed."
    else
        log_success "All NVIDIA packages already installed."
    fi
}

step2_install_opencl() {
    log_info "Step 2: Installing OpenCL..."

    if pkg_installed "$OPENCL_PKG"; then
        local ver
        ver=$(pacman -Q "$OPENCL_PKG" | awk '{print $2}')
        log_info "  $OPENCL_PKG already installed ($ver), skipping."
        return
    fi

    # Try the matching 580xx version from archive first
    local opencl_archive="https://archive.archlinux.org/packages/o/opencl-nvidia/opencl-nvidia-580.119.02-1-x86_64.pkg.tar.zst"

    log_info "  Downloading opencl-nvidia 580.119.02 from Arch archive..."
    if curl -sL "$opencl_archive" -o /tmp/opencl-nvidia-580.119.02-1-x86_64.pkg.tar.zst; then
        sudo pacman -U --noconfirm /tmp/opencl-nvidia-580.119.02-1-x86_64.pkg.tar.zst
        log_success "opencl-nvidia 580.119.02 installed."
    else
        log_warning "  Archive download failed. Installing from current repos (may be newer version)..."
        sudo pacman -S --noconfirm --needed "$OPENCL_PKG"
        log_success "opencl-nvidia installed from repos."
    fi
}

step3_install_cuda() {
    log_info "Step 3: Installing CUDA 12.3..."

    if [[ -d "$CUDA_DIR" ]]; then
        log_info "  CUDA directory already exists at $CUDA_DIR, skipping."
        return
    fi

    if [[ ! -f "$CUDA_RUN_FILE" ]]; then
        log_info "  Downloading CUDA 12.3 toolkit (~2.5GB)..."
        log_info "  URL: $CUDA_TOOLKIT_URL"
        wget -O "$CUDA_RUN_FILE" "$CUDA_TOOLKIT_URL"
    fi

    log_info "  Running CUDA installer (no driver, toolkit only)..."
    sudo sh "$CUDA_RUN_FILE" --toolkit --silent --override --no-drm --no-man-page

    # Move to /home to save root partition space
    if [[ -d "/usr/local/cuda-12.3" ]]; then
        sudo mv /usr/local/cuda-12.3 "$CUDA_DIR"
        sudo ln -sfn "$CUDA_DIR" "$CUDA_SYMLINK_VER"
        sudo ln -sfn "$CUDA_DIR" "$CUDA_SYMLINK"
        log_success "CUDA 12.3 installed and moved to $CUDA_DIR."
    elif [[ -d "$CUDA_DIR" ]]; then
        sudo ln -sfn "$CUDA_DIR" "$CUDA_SYMLINK_VER"
        sudo ln -sfn "$CUDA_DIR" "$CUDA_SYMLINK"
        log_success "CUDA 12.3 found at $CUDA_DIR."
    else
        log_error "CUDA installation directory not found. Check the installer output."
        return 1
    fi
}

step4_configure_env() {
    log_info "Step 4: Configuring environment variables..."

    local env_file="$HOME/.config/env-cuda.sh"
    mkdir -p "$(dirname "$env_file")"

    if [[ ! -f "$env_file" ]]; then
        cat > "$env_file" <<EOF
# CUDA 12.3 environment
export CUDA_HOME=$CUDA_DIR
export PATH="\$CUDA_HOME/bin:\$PATH"
export LD_LIBRARY_PATH="\$CUDA_HOME/lib64:\${LD_LIBRARY_PATH:-}"
EOF
        log_success "Created $env_file"
        log_info "  Source it from your shell profile:  source $env_file"
    else
        log_info "  $env_file already exists, skipping."
    fi
}

step5_pin_packages() {
    log_info "Step 5: Pinning NVIDIA packages in pacman.conf (IgnorePkg)..."

    if grep -q "^IgnorePkg.*nvidia-580xx-dkms" "$PACMAN_CONF" 2>/dev/null; then
        log_info "  IgnorePkg already configured, skipping."
        return
    fi

    if grep -q '^#IgnorePkg' "$PACMAN_CONF"; then
        sudo sed -i "s|^#IgnorePkg.*|$IGNOREPKG_LINE|" "$PACMAN_CONF"
    elif grep -q '^IgnorePkg' "$PACMAN_CONF"; then
        sudo sed -i "s|^IgnorePkg.*|$IGNOREPKG_LINE|" "$PACMAN_CONF"
    else
        sudo sed -i "/^\[options\]/a $IGNOREPKG_LINE" "$PACMAN_CONF"
    fi

    log_success "IgnorePkg configured in $PACMAN_CONF"
}

step6_verify() {
    log_info "Step 6: Verification..."

    echo ""
    echo "  --- Driver ---"
    if command -v nvidia-smi &>/dev/null; then
        nvidia-smi --query-gpu=name,driver_version,cuda_version --format=csv,noheader
    else
        log_warning "nvidia-smi not found. A reboot may be needed."
    fi

    echo ""
    echo "  --- Packages ---"
    pacman -Q | grep -iE 'nvidia|opencl' | while read -r line; do
        echo "  $line"
    done

    echo ""
    echo "  --- CUDA ---"
    if [[ -f "$CUDA_DIR/bin/nvcc" ]]; then
        "$CUDA_DIR/bin/nvcc" --version 2>/dev/null | grep release
    else
        log_warning "nvcc not found."
    fi

    echo ""
    echo "  --- Symlinks ---"
    ls -la "$CUDA_SYMLINK" 2>/dev/null || echo "  (no cuda symlink)"
    ls -la "$CUDA_SYMLINK_VER" 2>/dev/null || echo "  (no cuda-12.3 symlink)"
}

# --- Main ---

main() {
    echo ""
    log_info "========================================="
    log_info "  NVIDIA GPU Setup Script (580xx series)"
    log_info "========================================="
    echo ""

    check_root
    check_arch
    check_gpu

    echo ""
    read -rp "Proceed with installation? [Y/n] " confirm
    if [[ "${confirm,,}" == "n" ]]; then
        log_info "Aborted."
        exit 0
    fi

    step1_install_nvidia
    step2_install_opencl
    step3_install_cuda
    step4_configure_env
    step5_pin_packages

    echo ""
    step6_verify

    echo ""
    log_success "GPU setup complete."
    log_info "If this is a fresh driver install, reboot to load the kernel module."
    echo ""
}

main "$@"
