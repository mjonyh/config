#!/bin/bash

# ZSH Essential Plugins Installer
# Ensures zsh-syntax-highlighting and zsh-autosuggestions are available

echo "🚀 Installing ZSH Essential Plugins"
echo "===================================="

# Check if zplug exists or install it
if [[ ! -d ~/.zplug ]]; then
    echo "📦 Installing zplug..."
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Install essential plugins
echo "📦 Installing essential plugins..."
source ~/.zplug/init.zsh

# Essential plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install if not already installed
if ! zplug check; then
    echo "Installing missing plugins..."
    zplug install
fi

echo "✅ Essential ZSH plugins installed!"
echo ""
echo "These plugins are now available:"
echo "  • zsh-syntax-highlighting - Command syntax highlighting"
echo "  • zsh-autosuggestions - Command completion suggestions"
echo ""
echo "Run './optimize-zshrc.sh --install' to use optimized config with these plugins."
