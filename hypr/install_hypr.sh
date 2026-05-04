#!/bin/bash

# Exit on error
set -e

echo "Starting Hyprland environment installation..."

# 1. Update System
echo "Updating system..."
sudo pacman -Syu --noconfirm

# 2. Install Official Repository Packages
echo "Installing core components and utilities from official repos..."
OFFICIAL_PKGS=(
    hyprland hyprlock hyprpicker xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    waybar dunst swww wofi cliphist wl-clipboard udiskie blueman 
    network-manager-applet playerctl jq psmisc polkit-kde-agent swaylock
    qt5ct qt6ct kvantum pavucontrol cantarell-fonts kitty firefox 
    dolphin ark vlc signal-desktop steam gnome-boxes flatseal eog
    grim slurp swappy brightnessctl pamixer upower git base-devel
)

sudo pacman -S --needed --noconfirm "${OFFICIAL_PKGS[@]}"

# 3. Check for AUR Helper (yay/paru)
if command -v yay &> /dev/null; then
    AUR_HELPER="yay"
elif command -v paru &> /dev/null; then
    AUR_HELPER="paru"
else
    echo "AUR helper (yay/paru) not found. Installing yay..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin && makepkg -si --noconfirm
    AUR_HELPER="yay"
    cd -
fi

# 4. Install AUR Packages
echo "Installing themes, fonts, and specific apps from AUR..."
AUR_PKGS=(
    bibata-cursor-theme-bin
    ttf-jetbrains-mono-nerd
    # visual-studio-code-bin
    ghostty
    clapper
    # spotify
    # vesktop-bin
    mission-center-bin
)

$AUR_HELPER -S --needed --noconfirm "${AUR_PKGS[@]}"

# 5. Enable Necessary Services
echo "Enabling system services..."
sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service

echo "Installation complete! Please log out and select Hyprland at your login screen."
