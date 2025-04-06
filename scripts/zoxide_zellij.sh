#!/usr/bin/env bash

# A script to open a zellij session using zoxide for directory navigation

# Define colors
COLOR_GREEN="\033[0;32m"
COLOR_YELLOW="\033[0;33m"
COLOR_BLUE="\033[0;34m"
COLOR_RED="\033[0;31m"
COLOR_RESET="\033[0m"

# Function to show usage
usage() {
    echo -e "${COLOR_BLUE}Usage:${COLOR_RESET}"
    echo -e "  $(basename "$0") [DIRECTORY]"
    echo
    echo -e "${COLOR_BLUE}Description:${COLOR_RESET}"
    echo -e "  Open a zellij session in a directory, using zoxide for navigation"
    echo
    echo -e "${COLOR_BLUE}Arguments:${COLOR_RESET}"
    echo -e "  DIRECTORY    Optional directory argument. If not provided, zoxide interactive selector will be used"
    echo
    echo -e "${COLOR_BLUE}Examples:${COLOR_RESET}"
    echo -e "  $(basename "$0")            # Open interactive zoxide selector"
    echo -e "  $(basename "$0") projects   # Jump to best match for 'projects'"
    exit 1
}

# Check if zoxide is installed
if ! command -v zoxide &> /dev/null; then
    echo -e "${COLOR_RED}Error: zoxide is not installed${COLOR_RESET}"
    echo -e "Please install zoxide: https://github.com/ajeetdsouza/zoxide"
    exit 1
fi

# Check if zellij is installed
if ! command -v zellij &> /dev/null; then
    echo -e "${COLOR_RED}Error: zellij is not installed${COLOR_RESET}"
    echo -e "Please install zellij: https://zellij.dev/documentation/installation.html"
    exit 1
fi

# Show help if requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
fi

# Change to directory
if [[ $# -eq 0 ]]; then
    # Interactive selection with zoxide
    dir=$(zoxide query -i)
    if [[ -z "$dir" ]]; then
        echo -e "${COLOR_YELLOW}No directory selected, exiting.${COLOR_RESET}"
        exit 0
    fi
else
    # Use provided argument to find directory
    dir=$(zoxide query "$1")
    if [[ -z "$dir" ]]; then
        echo -e "${COLOR_RED}Error: No match found for '$1'${COLOR_RESET}"
        exit 1
    fi
fi

# Navigate to the directory
cd "$dir" || exit 1

# Create a session name based on directory name
session_name=$(basename "$dir" | tr ' ' '_' | tr '.' '_')

# Check if a zellij session exists with this name
if zellij list-sessions 2>/dev/null | grep -q "^$session_name"; then
    echo -e "${COLOR_GREEN}Attaching to existing zellij session: ${COLOR_BLUE}$session_name${COLOR_RESET}"
    zellij attach "$session_name"
else
    echo -e "${COLOR_GREEN}Creating new zellij session: ${COLOR_BLUE}$session_name${COLOR_RESET}"
    zellij --session "$session_name"
fi