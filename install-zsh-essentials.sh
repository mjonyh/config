#!/usr/bin/env zsh

# ZSH Essential Plugins Installer (Fixed)
# Ensures zsh-syntax-highlighting and zsh-autosuggestions are available

set -e

echo "🚀 Installing ZSH Essential Plugins"
echo "===================================="

# Check if we're running in zsh
if [[ -z "$ZSH_VERSION" ]]; then
    echo "❌ This script must run in ZSH, not bash!"
    echo "🔧 Fix: Run with zsh:"
    echo "   zsh ./install-zsh-essentials.sh"
    echo ""
    echo "🚀 Or use the optimized installer instead:"
    echo "   ./optimize-zshrc.sh --install"
    exit 1
fi

echo "✅ Running in ZSH version: $ZSH_VERSION"

# Method 1: Try Homebrew installation first (more reliable on macOS)
if command -v brew >/dev/null 2>&1; then
    echo "📦 Installing via Homebrew (recommended)..."
    
    if ! brew list zsh-syntax-highlighting >/dev/null 2>&1; then
        echo "Installing zsh-syntax-highlighting..."
        brew install zsh-syntax-highlighting
    else
        echo "✅ zsh-syntax-highlighting already installed via Homebrew"
    fi
    
    if ! brew list zsh-autosuggestions >/dev/null 2>&1; then
        echo "Installing zsh-autosuggestions..."
        brew install zsh-autosuggestions
    else
        echo "✅ zsh-autosuggestions already installed via Homebrew"
    fi
    
    echo ""
    echo "📋 To use Homebrew-installed plugins, add to your .zshrc:"
    echo "source \$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    echo "source \$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    echo ""
    
# Method 2: Try zplug installation
elif [[ -d ~/.zplug ]] || read -q "?Install via zplug? [y/N]: "; then
    echo ""
    
    # Install zplug if not present
    if [[ ! -d ~/.zplug ]]; then
        echo "📦 Installing zplug..."
        git clone https://github.com/zplug/zplug ~/.zplug
    fi
    
    # Source zplug in a zsh context
    echo "📦 Installing essential plugins via zplug..."
    
    # Create a temporary zsh script to handle zplug
    cat > /tmp/install_plugins.zsh << 'ZPLUG_EOF'
#!/usr/bin/env zsh
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check; then
    echo "Installing missing plugins..."
    zplug install
else
    echo "✅ Plugins already installed"
fi
ZPLUG_EOF
    
    # Run the zsh script
    zsh /tmp/install_plugins.zsh
    rm -f /tmp/install_plugins.zsh
    
    echo "✅ Zplug installation complete"

# Method 3: Manual git installation
else
    echo "📦 Installing manually via git..."
    
    mkdir -p ~/.zsh/plugins
    
    # Install zsh-autosuggestions
    if [[ ! -d ~/.zsh/plugins/zsh-autosuggestions ]]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
    else
        echo "✅ zsh-autosuggestions already installed"
    fi
    
    # Install zsh-syntax-highlighting  
    if [[ ! -d ~/.zsh/plugins/zsh-syntax-highlighting ]]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
    else
        echo "✅ zsh-syntax-highlighting already installed"
    fi
    
    echo ""
    echo "📋 To use manually installed plugins, add to your .zshrc:"
    echo "source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
    echo "source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

echo ""
echo "🎉 Installation Complete!"
echo "========================="
echo ""
echo "Essential ZSH plugins are now available:"
echo "  • ✅ zsh-syntax-highlighting - Command syntax highlighting"
echo "  • ✅ zsh-autosuggestions - Command completion suggestions"
echo ""
echo "🚀 Next steps:"
echo "  1. Run: ./optimize-zshrc.sh --install"
echo "  2. Restart your shell: exec zsh"
echo "  3. Enjoy fast startup + syntax highlighting!"
