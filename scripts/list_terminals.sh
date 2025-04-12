#!/bin/bash
#
# List all available terminal emulators installed in the system
#

echo "Searching for installed terminal emulators..."
echo "=============================================="

# Initialize array to store found terminals
declare -a FOUND_TERMINALS

# Common terminal emulators to check
TERMINALS=(
    "alacritty"
    "gnome-terminal"
    "konsole"
    "xterm"
    "rxvt"
    "urxvt"
    "terminology"
    "xfce4-terminal"
    "tilix"
    "kitty"
    "terminator"
    "cool-retro-term"
    "st"
    "foot"
    "termite"
    "sakura"
    "lxterminal"
    "qterminal"
    "mate-terminal"
    "hyper"
    "wezterm"
    "mlterm"
    "tilda"
    "yakuake"
    "termux"
    "guake"
    "deepin-terminal"
    "roxterm"
    "lilyterm"
    "eterm"
    "xvt"
    "pantheon-terminal"
    "tabby"
    "ghostty"
    "zellij"
    "tmux"
    "screen"
)

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check desktop entries for terminals
find_desktop_terminals() {
    local desktop_files=(
        "/usr/share/applications"
        "/usr/local/share/applications"
        "$HOME/.local/share/applications"
    )
    
    for dir in "${desktop_files[@]}"; do
        if [ -d "$dir" ]; then
            grep -l "Terminal=true" "$dir"/*.desktop 2>/dev/null | while read -r file; do
                local name=$(grep -oP "(?<=^Name=).*" "$file" | head -1)
                local exec=$(grep -oP "(?<=^Exec=).*" "$file" | head -1 | sed 's/ %.*//')
                if [ -n "$name" ] && [ -n "$exec" ]; then
                    echo "  - $name ($exec) [Desktop Entry]"
                    FOUND_TERMINALS+=("$name")
                fi
            done
        fi
    done
}

# Main function to check terminals
check_terminals() {
    echo "System terminals found:"
    echo "----------------------"
    
    # Check common terminals by command
    for terminal in "${TERMINALS[@]}"; do
        if command_exists "$terminal"; then
            echo "  - $terminal [Command]"
            FOUND_TERMINALS+=("$terminal")
        fi
    done
    
    # Try to find version info for major terminals
    if command_exists "alacritty"; then
        local version=$(alacritty --version 2>/dev/null | head -1)
        [ -n "$version" ] && echo "    * $version"
    fi
    
    if command_exists "kitty"; then
        local version=$(kitty --version 2>/dev/null | head -1)
        [ -n "$version" ] && echo "    * $version"
    fi
    
    if command_exists "tmux"; then
        local version=$(tmux -V 2>/dev/null)
        [ -n "$version" ] && echo "    * $version"
    fi
    
    if command_exists "zellij"; then
        local version=$(zellij --version 2>/dev/null)
        [ -n "$version" ] && echo "    * $version"
    fi
    
    # Additional check for the default terminal set in the system
    if command_exists "update-alternatives"; then
        echo -e "\nDefault terminal (via update-alternatives):"
        echo "----------------------------------------"
        update-alternatives --get-selections | grep "x-terminal-emulator" || echo "  No default terminal set"
    fi
    
    # Additional check via xdg-mime
    if command_exists "xdg-mime"; then
        echo -e "\nDefault terminal application (via xdg-mime):"
        echo "----------------------------------------"
        xdg-mime query default x-scheme-handler/terminal || echo "  No default terminal application set"
    fi
    
    # Terminal multiplexers
    echo -e "\nTerminal multiplexers:"
    echo "--------------------"
    for multiplexer in "tmux" "screen" "zellij"; do
        if command_exists "$multiplexer"; then
            echo "  - $multiplexer [installed]"
        fi
    done
    
    # Find terminals from desktop entries
    echo -e "\nAdditional terminals (from desktop entries):"
    echo "----------------------------------------"
    find_desktop_terminals
    
    # Report summary
    if [ ${#FOUND_TERMINALS[@]} -eq 0 ]; then
        echo -e "\nNo terminal emulators were found."
    else
        echo -e "\nSummary: Found ${#FOUND_TERMINALS[@]} terminal emulators."
    fi
}

# Run the main function
check_terminals

exit 0