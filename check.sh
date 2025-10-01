#!/bin/bash
#
# Font Support Checker - Enhanced Version
# Tests if terminal and font support various unicode symbols and font features
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}       Font & Terminal Checker          ${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo
}

print_section() {
    echo -e "${YELLOW}--- $1 ---${NC}"
}

print_result() {
    if [[ $2 == "pass" ]]; then
        echo -e "✅ ${GREEN}$1${NC}"
    else
        echo -e "❌ ${RED}$1${NC}"
    fi
}

# Test basic Unicode support
test_basic_unicode() {
    print_section "Basic Unicode Support"
    echo -n "Basic symbols: "
    echo "→ ← ↑ ↓ ✓ ✗ ★ ♦ ♠ ♣ ♥"
    echo -n "Math symbols: "
    echo "≤ ≥ ≠ ± ∞ π α β γ δ"
    echo -n "Box drawing: "
    echo "─ │ ┌ ┐ └ ┘ ├ ┤ ┬ ┴ ┼"
    echo
}

# Test Powerline symbols (common in shell prompts)
test_powerline() {
    print_section "Powerline Font Symbols"
    echo -n "Powerline arrows: "
    echo "               "
    echo -n "Branch symbol: "
    echo ""
    echo -n "Lock symbol: "
    echo ""
    echo
}

# Test Nerd Font symbols (used by many terminal apps)
test_nerd_fonts() {
    print_section "Nerd Font Symbols (for exa, nvim, etc.)"
    echo -n "File icons: "
    echo "        "
    echo -n "Folder icons: "
    echo "   "
    echo -n "Git symbols: "
    echo "     "
    echo -n "Programming: "
    echo "       "
    echo
}

# Test color support
test_color_support() {
    print_section "Color Support Test"
    echo -n "Basic colors: "
    for color in {30..37}; do
        echo -en "\033[${color}m●\033[0m "
    done
    echo
    
    echo -n "Bright colors: "
    for color in {90..97}; do
        echo -en "\033[${color}m●\033[0m "
    done
    echo
    
    echo -n "256-color test: "
    for color in {196,202,208,214,220,226,190,154,118,82,46,47,48,49,50,51}; do
        echo -en "\033[38;5;${color}m●\033[0m"
    done
    echo
    echo
}

# Test terminal capabilities
test_terminal_info() {
    print_section "Terminal Information"
    echo "TERM: $TERM"
    echo "Terminal: $(ps -p $PPID -o comm= 2>/dev/null || echo 'Unknown')"
    
    if command -v tput >/dev/null 2>&1; then
        echo "Colors supported: $(tput colors 2>/dev/null || echo 'Unknown')"
        echo "Terminal size: $(tput cols 2>/dev/null || echo '?') x $(tput lines 2>/dev/null || echo '?')"
    fi
    echo
}

# Test font rendering with various character sets
test_font_rendering() {
    print_section "Font Rendering Tests"
    
    echo "ASCII Art Test:"
    echo "╔══════════════════════════════════════════════════════════════════╗"
    echo "║  If this box looks perfect, your terminal supports box drawing   ║"
    echo "╚══════════════════════════════════════════════════════════════════╝"
    echo
    
    echo "Monospace Test (should align perfectly):"
    echo "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    echo "abcdefghijklmnopqrstuvwxyz"
    echo "0123456789!@#$%^&*()_+-="
    echo "||||||||||||||||||||||||||||"
    echo
}

# Test specific font features for development
test_dev_features() {
    print_section "Development Font Features"
    
    echo "Ligature test (if supported):"
    echo "== != <= >= -> <- => <-"
    echo "|| && ++ -- ** // /* */"
    echo
    
    echo "Zero distinction test:"
    echo "0O o (zero, capital O, lowercase o)"
    echo "1l I | (one, lowercase L, capital i, pipe)"
    echo
}

# Main execution
main() {
    print_header
    
    test_terminal_info
    test_basic_unicode
    test_powerline
    test_nerd_fonts
    test_color_support
    test_font_rendering
    test_dev_features
    
    echo -e "${BLUE}========================================${NC}"
    echo -e "${YELLOW}Font Recommendations:${NC}"
    echo "• For programming: JetBrains Mono, Fira Code, Cascadia Code"
    echo "• For terminals: Nerd Font patched versions"
    echo "• Current good options: JetBrains Mono Nerd Font, Hack Nerd Font"
    echo -e "${BLUE}========================================${NC}"
}

# Check if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
