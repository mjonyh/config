#!/bin/bash
#
# List available system updates for various package managers
# Supports: apt, pacman, dnf, yum, zypper, flatpak, snap, brew
#

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# Function to print section headers
print_header() {
    echo -e "\n${BOLD}${BLUE}$1${NC}"
    echo -e "${BLUE}$(printf '%.0s-' $(seq 1 ${#1}))${NC}\n"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to count updates
count_updates() {
    if [ -n "$1" ]; then
        echo "$1" | grep -v "^$" | wc -l
    else
        echo "0"
    fi
}

# Function to show updates with a counter
show_updates() {
    local updates="$1"
    local count=$(count_updates "$updates")
    local size="$2"
    
    if [ "$count" -gt 0 ]; then
        if [ -n "$size" ]; then
            echo -e "${GREEN}$count update(s) available - Download size: $size${NC}"
        else
            echo -e "${GREEN}$count update(s) available${NC}"
        fi
        echo -e "$updates"
    else
        echo -e "${GREEN}No updates available.${NC}"
    fi
}

# Start the script
echo -e "${BOLD}${MAGENTA}System Update Checker${NC}"
echo -e "${MAGENTA}======================${NC}"
echo -e "Checking for updates across all package managers..."

# Initialize counters and download size trackers
TOTAL_UPDATES=0
TOTAL_SIZE=0
TOTAL_SIZE_READABLE=""

# Initialize update variables
APT_UPDATES=""
APT_SIZE=""
PACMAN_UPDATES=""
PACMAN_SIZE=""
YAY_UPDATES=""
DNF_UPDATES=""
DNF_SIZE=""
YUM_UPDATES=""
YUM_SIZE=""
ZYPPER_UPDATES=""
ZYPPER_SIZE=""
FLATPAK_UPDATES=""
FLATPAK_SIZE=""
SNAP_UPDATES=""
BREW_UPDATES=""

# Check for apt updates (Debian/Ubuntu)
if command_exists apt; then
    print_header "APT (Debian/Ubuntu)"
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo apt update -qq
    
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    APT_UPDATES=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | sort)
    
    # Get download size
    APT_SIZE=""
    if [ -n "$APT_UPDATES" ]; then
        echo -e "${YELLOW}Calculating download size...${NC}"
        APT_SIZE=$(apt-get upgrade --dry-run | grep -i "after this operation" | awk '{print $4$5}')
    fi
    
    show_updates "$APT_UPDATES" "$APT_SIZE"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$APT_UPDATES")))
fi

# Check for pacman updates (Arch Linux)
if command_exists pacman; then
    print_header "PACMAN (Arch Linux)"
    echo -e "${YELLOW}Synchronizing package database...${NC}"
    sudo pacman -Sy --noconfirm > /dev/null
    
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    PACMAN_UPDATES=$(pacman -Qu | sort)
    
    # Get download size
    PACMAN_SIZE=""
    if [ -n "$PACMAN_UPDATES" ]; then
        echo -e "${YELLOW}Calculating download size...${NC}"
        PACMAN_SIZE=$(pacman -Syu --print-format "%s" --noconfirm --downloadonly 2>/dev/null | tail -n1 | awk '{sum+=$1} END {if (sum < 1024) printf "%.1fKB", sum; else if (sum < 1048576) printf "%.1fMB", sum/1024; else printf "%.1fGB", sum/1048576}')
    fi
    
    show_updates "$PACMAN_UPDATES" "$PACMAN_SIZE"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$PACMAN_UPDATES")))
fi

# Check for yay updates (AUR helper)
if command_exists yay; then
    print_header "YAY (AUR Helper)"
    echo -e "${YELLOW}Checking for AUR updates...${NC}"
    YAY_UPDATES=$(yay -Qua 2>/dev/null | sort)
    show_updates "$YAY_UPDATES" 
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$YAY_UPDATES")))
fi

# Check for dnf updates (Fedora/RHEL)
if command_exists dnf; then
    print_header "DNF (Fedora/RHEL)"
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    DNF_UPDATES=$(dnf check-update -q | grep -v "^$" | grep -v "Last metadata" | sort)
    
    # Get download size
    DNF_SIZE=""
    if [ -n "$DNF_UPDATES" ]; then
        echo -e "${YELLOW}Calculating download size...${NC}"
        DNF_SIZE=$(dnf updateinfo --list | grep -i "Size:" | awk '{sum+=$2} END {if (sum < 1024) printf "%.1fKB", sum; else if (sum < 1048576) printf "%.1fMB", sum/1024; else printf "%.1fGB", sum/1048576}')
        
        # Alternative method if the above fails
        if [ -z "$DNF_SIZE" ]; then
            DNF_SIZE=$(dnf upgrade --assumeno | grep -i "Total download size:" | awk '{print $4$5}')
        fi
    fi
    
    show_updates "$DNF_UPDATES" "$DNF_SIZE"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$DNF_UPDATES")))
fi

# Check for yum updates (older RHEL/CentOS)
if command_exists yum && ! command_exists dnf; then
    print_header "YUM (RHEL/CentOS)"
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    YUM_UPDATES=$(yum check-update -q | grep -v "^$" | grep -v "Last metadata" | sort)
    show_updates "$YUM_UPDATES"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$YUM_UPDATES")))
fi

# Check for zypper updates (openSUSE)
if command_exists zypper; then
    print_header "ZYPPER (openSUSE)"
    echo -e "${YELLOW}Refreshing repositories...${NC}"
    sudo zypper refresh > /dev/null
    
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    ZYPPER_UPDATES=$(zypper list-updates | grep -v "^S" | grep -v "^--" | sort)
    show_updates "$ZYPPER_UPDATES"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$ZYPPER_UPDATES")))
fi

# Check for Flatpak updates
if command_exists flatpak; then
    print_header "FLATPAK"
    echo -e "${YELLOW}Checking for Flatpak updates...${NC}"
    FLATPAK_UPDATE_OUTPUT=$(flatpak update --no-deps --dry-run 2>&1)
    FLATPAK_UPDATES=$(echo "$FLATPAK_UPDATE_OUTPUT" | grep -E "^[[:space:]]+[0-9]+\.[0-9]+" | sort)
    
    # Get download size
    FLATPAK_SIZE=""
    if [ -n "$FLATPAK_UPDATES" ]; then
        echo -e "${YELLOW}Calculating download size...${NC}"
        FLATPAK_SIZE=$(echo "$FLATPAK_UPDATE_OUTPUT" | grep -i "Download size:" | head -1 | sed 's/.*Download size: //')
    fi
    
    show_updates "$FLATPAK_UPDATES" "$FLATPAK_SIZE"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$FLATPAK_UPDATES")))
fi

# Check for Snap updates
if command_exists snap; then
    print_header "SNAP"
    echo -e "${YELLOW}Checking for Snap updates...${NC}"
    SNAP_UPDATES=$(snap refresh --list 2>/dev/null | grep -v "All snaps up to date" | sort)
    show_updates "$SNAP_UPDATES"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$SNAP_UPDATES")))
fi

# Check for Homebrew updates (macOS/Linux)
if command_exists brew; then
    print_header "HOMEBREW"
    echo -e "${YELLOW}Updating Homebrew...${NC}"
    brew update > /dev/null
    
    echo -e "${YELLOW}Checking for upgradable packages...${NC}"
    BREW_UPDATES=$(brew outdated | sort)
    show_updates "$BREW_UPDATES"
    TOTAL_UPDATES=$((TOTAL_UPDATES + $(count_updates "$BREW_UPDATES")))
fi

# Calculate human-readable total size
calculate_total_size() {
    # Parse sizes to bytes
    if [ -n "$APT_SIZE" ]; then
        local apt_bytes=$(echo "$APT_SIZE" | sed 's/[A-Za-z]//g')
        local apt_unit=$(echo "$APT_SIZE" | sed 's/[0-9.]//g')
        case $apt_unit in
            KB) apt_bytes=$(echo "$apt_bytes * 1024" | bc) ;;
            MB) apt_bytes=$(echo "$apt_bytes * 1048576" | bc) ;;
            GB) apt_bytes=$(echo "$apt_bytes * 1073741824" | bc) ;;
        esac
        TOTAL_SIZE=$(echo "$TOTAL_SIZE + $apt_bytes" | bc)
    fi
    
    if [ -n "$PACMAN_SIZE" ]; then
        local pacman_bytes=$(echo "$PACMAN_SIZE" | sed 's/[A-Za-z]//g')
        local pacman_unit=$(echo "$PACMAN_SIZE" | sed 's/[0-9.]//g')
        case $pacman_unit in
            KB) pacman_bytes=$(echo "$pacman_bytes * 1024" | bc) ;;
            MB) pacman_bytes=$(echo "$pacman_bytes * 1048576" | bc) ;;
            GB) pacman_bytes=$(echo "$pacman_bytes * 1073741824" | bc) ;;
        esac
        TOTAL_SIZE=$(echo "$TOTAL_SIZE + $pacman_bytes" | bc)
    fi
    
    if [ -n "$DNF_SIZE" ]; then
        local dnf_bytes=$(echo "$DNF_SIZE" | sed 's/[A-Za-z]//g')
        local dnf_unit=$(echo "$DNF_SIZE" | sed 's/[0-9.]//g')
        case $dnf_unit in
            KB) dnf_bytes=$(echo "$dnf_bytes * 1024" | bc) ;;
            MB) dnf_bytes=$(echo "$dnf_bytes * 1048576" | bc) ;;
            GB) dnf_bytes=$(echo "$dnf_bytes * 1073741824" | bc) ;;
        esac
        TOTAL_SIZE=$(echo "$TOTAL_SIZE + $dnf_bytes" | bc)
    fi
    
    # Convert total size to human-readable format
    if [ "$TOTAL_SIZE" -gt 0 ]; then
        if [ "$TOTAL_SIZE" -lt 1024 ]; then
            TOTAL_SIZE_READABLE="${TOTAL_SIZE}B"
        elif [ "$TOTAL_SIZE" -lt 1048576 ]; then
            TOTAL_SIZE_READABLE="$(echo "scale=1; $TOTAL_SIZE/1024" | bc)KB"
        elif [ "$TOTAL_SIZE" -lt 1073741824 ]; then
            TOTAL_SIZE_READABLE="$(echo "scale=1; $TOTAL_SIZE/1048576" | bc)MB"
        else
            TOTAL_SIZE_READABLE="$(echo "scale=2; $TOTAL_SIZE/1073741824" | bc)GB"
        fi
    fi
}

# Calculate total size
calculate_total_size

# Summary
print_header "SUMMARY"
if [ -n "$TOTAL_SIZE_READABLE" ]; then
    echo -e "${BOLD}${MAGENTA}Total updates available: ${TOTAL_UPDATES} (Download size: ${TOTAL_SIZE_READABLE})${NC}\n"
else
    echo -e "${BOLD}${MAGENTA}Total updates available: ${TOTAL_UPDATES}${NC}\n"
fi

# Update commands guide
if [ $TOTAL_UPDATES -gt 0 ]; then
    print_header "UPDATE COMMANDS"
    echo -e "To update your system, you can run the following commands:\n"
    
    [ -n "$APT_UPDATES" ] && echo -e "${CYAN}APT:${NC} sudo apt upgrade"
    [ -n "$PACMAN_UPDATES" ] && echo -e "${CYAN}PACMAN:${NC} sudo pacman -Syu"
    [ -n "$YAY_UPDATES" ] && echo -e "${CYAN}YAY:${NC} yay -Syu"
    [ -n "$DNF_UPDATES" ] && echo -e "${CYAN}DNF:${NC} sudo dnf upgrade"
    [ -n "$YUM_UPDATES" ] && echo -e "${CYAN}YUM:${NC} sudo yum update"
    [ -n "$ZYPPER_UPDATES" ] && echo -e "${CYAN}ZYPPER:${NC} sudo zypper update"
    [ -n "$FLATPAK_UPDATES" ] && echo -e "${CYAN}FLATPAK:${NC} flatpak update"
    [ -n "$SNAP_UPDATES" ] && echo -e "${CYAN}SNAP:${NC} sudo snap refresh"
    [ -n "$BREW_UPDATES" ] && echo -e "${CYAN}HOMEBREW:${NC} brew upgrade"
fi

exit 0