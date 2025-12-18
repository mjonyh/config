#!/bin/bash

# Catppuccin Mocha exa Color Preview Tool

echo "🎨 Catppuccin Mocha exa Color Preview"
echo "====================================="

# Set Catppuccin Mocha colors
export EXA_COLORS="ur=38;5;250:uw=38;5;203:ux=38;5;151:ue=38;5;151:gr=38;5;145:gw=38;5;203:gx=38;5;151:tr=38;5;102:tw=38;5;203:tx=38;5;151:su=38;5;234;48;5;203:sf=38;5;234;48;5;203:xa=38;5;102:*.7z=38;5;216:*.tar=38;5;216:*.zip=38;5;216:*.gz=38;5;216:*.bz2=38;5;216:*.xz=38;5;216:*.jpg=38;5;218:*.jpeg=38;5;218:*.png=38;5;218:*.gif=38;5;218:*.svg=38;5;218:*.mp4=38;5;218:*.mkv=38;5;218:*.avi=38;5;218:*.mp3=38;5;152:*.wav=38;5;152:*.flac=38;5;152:*.ogg=38;5;152:*.pdf=38;5;222:*.doc=38;5;222:*.txt=38;5;189:*.md=38;5;189:*.py=38;5;117:*.js=38;5;117:*.html=38;5;203:*.css=38;5;117:*.json=38;5;222:*.yml=38;5;222:*.sh=38;5;151:*.gitignore=38;5;102"

echo ""
echo "📂 Directory listing with Catppuccin Mocha colors:"
echo "------------------------------------------------"
exa -l --icons --git --group-directories-first

echo ""
echo "🌳 Tree view with Catppuccin colors:"
echo "------------------------------------"
exa --tree --level=2 --icons --git

echo ""
echo "🎯 Color mapping:"
echo "• 📁 Directories: Blue tones"
echo "• 📦 Archives: Peach tones (.zip, .tar, etc.)"
echo "• 🖼️  Images: Pink/Mauve tones (.jpg, .png, etc.)" 
echo "• 🎵 Audio: Teal/Sky tones (.mp3, .wav, etc.)"
echo "• 📄 Documents: Yellow tones (.pdf, .txt, etc.)"
echo "• 💻 Code: Blue/Lavender tones (.py, .js, etc.)"
echo "• 🌐 Web: Various colors (.html=red, .css=blue, etc.)"
echo ""
echo "✨ If you like these colors, they're already set in your zshrc files!"
echo "   Just restart your shell: exec zsh"