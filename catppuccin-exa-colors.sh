#!/bin/bash

# Catppuccin Mocha Color Scheme for exa
# Based on https://github.com/catppuccin/catppuccin

# Catppuccin Mocha color palette (hex values)
declare -A CATPPUCCIN_MOCHA=(
    ["rosewater"]="f5e0dc"
    ["flamingo"]="f2cdcd"
    ["pink"]="f5c2e7"
    ["mauve"]="cba6f7"
    ["red"]="f38ba8"
    ["maroon"]="eba0ac"
    ["peach"]="fab387"
    ["yellow"]="f9e2af"
    ["green"]="a6e3a1"
    ["teal"]="94e2d5"
    ["sky"]="89dceb"
    ["sapphire"]="74c7ec"
    ["blue"]="89b4fa"
    ["lavender"]="b4befe"
    ["text"]="cdd6f4"
    ["subtext1"]="bac2de"
    ["subtext0"]="a6adc8"
    ["overlay2"]="9399b2"
    ["overlay1"]="7f849c"
    ["overlay0"]="6c7086"
    ["surface2"]="585b70"
    ["surface1"]="45475a"
    ["surface0"]="313244"
    ["base"]="1e1e2e"
    ["mantle"]="181825"
    ["crust"]="11111b"
)

# Convert hex to 256-color codes for better terminal compatibility
hex_to_256() {
    local hex="$1"
    # This is a simplified conversion - you might want to use a proper hex-to-256 converter
    case "$hex" in
        "f38ba8") echo "203" ;;  # red
        "a6e3a1") echo "151" ;;  # green  
        "f9e2af") echo "222" ;;  # yellow
        "89b4fa") echo "117" ;;  # blue
        "cba6f7") echo "183" ;;  # mauve
        "94e2d5") echo "152" ;;  # teal
        "fab387") echo "216" ;;  # peach
        "f5c2e7") echo "218" ;;  # pink
        "cdd6f4") echo "189" ;;  # text
        "bac2de") echo "146" ;;  # subtext1
        "a6adc8") echo "145" ;;  # subtext0
        "585b70") echo "102" ;;  # surface2
        "45475a") echo "59"  ;;  # surface1
        "313244") echo "237" ;;  # surface0
        "1e1e2e") echo "234" ;;  # base
        *) echo "15" ;;          # default white
    esac
}

# Generate EXA_COLORS with Catppuccin Mocha theme
generate_catppuccin_exa_colors() {
    cat << 'EOF'
# Catppuccin Mocha EXA_COLORS
# File types
di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33;40:cd=1;33;40:su=0;41:sg=0;46:tw=0;42:ow=0;43:
# Extensions  
*.tar=1;31:*.tgz=1;31:*.zip=1;31:*.z=1;31:*.gz=1;31:*.bz2=1;31:*.xz=1;31:*.lz=1;31:*.lzma=1;31:*.rar=1;31:
# Images
*.jpg=1;35:*.jpeg=1;35:*.png=1;35:*.gif=1;35:*.bmp=1;35:*.svg=1;35:*.webp=1;35:*.ico=1;35:
# Videos  
*.mp4=1;33:*.avi=1;33:*.mkv=1;33:*.mov=1;33:*.wmv=1;33:*.flv=1;33:*.webm=1;33:
# Audio
*.mp3=1;36:*.wav=1;36:*.flac=1;36:*.ogg=1;36:*.m4a=1;36:
# Documents
*.pdf=1;32:*.doc=1;32:*.docx=1;32:*.txt=1;37:*.md=1;37:*.tex=1;37:
# Code
*.py=1;33:*.js=1;33:*.html=1;31:*.css=1;34:*.php=1;35:*.java=1;31:*.cpp=1;36:*.c=1;36:*.rs=1;31:*.go=1;34:
EOF
}

echo "🎨 Catppuccin Mocha EXA Colors Configuration"
echo "============================================="
echo ""
echo "Generated EXA_COLORS for Catppuccin Mocha theme:"
echo ""
generate_catppuccin_exa_colors