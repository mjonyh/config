# 🏠 Personal Configuration Files

A comprehensive collection of dotfiles and setup scripts for macOS and Arch Linux environments, featuring modern tools and workflows.

![Repository Size](https://img.shields.io/github/repo-size/mjonyh/config)
![Last Commit](https://img.shields.io/github/last-commit/mjonyh/config)
![License](https://img.shields.io/github/license/mjonyh/config)

## 📸 Screenshots

| Shell (ZSH + Starship) | Neovim (Lua Config) | Tmux Sessions |
|-------------------------|---------------------|---------------|
| ![zsh](screenshots/zsh.png) | ![vim](screenshots/vim.png) | ![tmux](screenshots/tmux.png) |

---

## 🚀 Quick Setup

### One-Line Installation

**macOS:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/new_mac_setup.sh)"
```

**Arch Linux:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/new_arch_setup.sh)"
```

**Enhanced Dotfiles Setup:**
```bash
curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/symlink-configs.sh | bash
```

**Legacy Dotfiles Setup:**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/symdotfiles.sh)"
```

---

## 🛠️ Configuration Files

### 🐚 Shell Environment

#### `zshrc` - ZSH Configuration
- **Features:** Advanced shell setup with FZF integration, custom functions, and optimized workflows
- **Includes:** 
  - Environment variables and PATH configuration
  - FZF fuzzy finder setup and keybindings
  - Custom aliases and functions
  - History optimization (100k entries)
  - Completion system configuration
- **Dependencies:** `zsh`, `fzf`, `oh-my-zsh` (optional)
- **Size:** 374 lines of comprehensive shell configuration

#### `starship.toml` - Cross-Shell Prompt
- **Features:** Fast, customizable prompt with git integration and status indicators
- **Modules:** Git branch/status, directory, command duration, error codes
- **Theme:** Custom color scheme with catppuccin-inspired palette
- **Performance:** Written in Rust, minimal startup time
- **Size:** 190 lines with detailed module configuration

### 🖥️ Terminal & Multiplexer

#### `tmux.conf` - Terminal Multiplexer
- **Features:** Enhanced tmux setup with vim-like navigation and custom keybindings
- **Includes:**
  - 256-color support and RGB color configuration
  - Custom status bar with system information
  - Vim-like pane navigation (`Ctrl-h/j/k/l`)
  - Mouse support and clipboard integration
  - Session restoration capabilities
- **Plugin Manager:** Ready for tmux plugin manager (TPM)
- **Size:** 129 lines of optimized configuration

#### `ghostty/config` - Modern Terminal Emulator
- **Features:** GPU-accelerated terminal with native macOS integration
- **Settings:** Font configuration, color schemes, and performance optimizations
- **Font:** Hack Nerd Font family for icon support

#### `tmuxp/` - Tmux Session Templates  
Pre-configured session layouts for different projects:
- **Academic Sessions:** `phy-111A.yaml`, `phy-229.yaml`, `phy-439.yaml`, `phy-455.yaml`
- **Development:** `vim-config.yaml`, `rc-config.yaml`
- **Productivity:** `journals.yaml`

### 📝 Text Editors

#### `nvim/` - Modern Neovim Configuration (Lua)
**Architecture:** Modular Lua-based configuration with lazy loading

**Core Files:**
- `init.lua` - Entry point that loads all modules
- `lua/config/lazy.lua` - Lazy.nvim plugin manager setup
- `lua/config/maps.lua` - Custom keybindings and shortcuts
- `lua/config/settings.lua` - Editor settings and options

**Plugin Suite (22 plugins):**
- **Completion:** `nvim-cmp` with multiple sources
- **AI Assistance:** `codeium.vim` for AI-powered completions
- **File Management:** `neotree.lua` - Modern file explorer
- **Fuzzy Finding:** `fzf.lua`, `telescope.lua` - Advanced file/text search
- **Git Integration:** `gitsigns.lua` - Git change indicators
- **Syntax & Language:** `treesitter.lua` - Advanced syntax highlighting
- **UI Enhancement:** `lualine.lua` - Customizable statusline
- **Productivity:** `nvim-surround.lua`, `autopairs.lua`, `which-key.lua`
- **Documentation:** `neorg.lua`, `render-markdown.lua`, `markmap.lua`
- **Navigation:** `vim-tmux-navigator.lua`, `lightspeed.lua`
- **Utilities:** `colorizer.lua`, `noice.lua`, `snaks.lua`

#### `vimrc` - Legacy Vim Configuration
- **Purpose:** Fallback configuration for systems without Neovim
- **Features:** Comprehensive vim setup with plugins via vim-plug
- **Size:** 11,726 lines of traditional vim configuration
- **Plugins:** Includes NERDtree, vim-airline, YouCompleteMe, and more

### 🪟 Window Management

#### `hypr/` - Hyprland Wayland Compositor (Linux)
**Configuration Structure:**
- `hyprland.conf` - Main configuration file (4,585 lines)
- `keybindings.conf` - Custom keyboard shortcuts (8,482 lines)
- `animations.conf` - Window animation settings
- `monitors.conf` - Multi-monitor setup
- `windowrules.conf` - Window behavior rules (6,041 lines)
- `hyprlock.conf` - Screen lock configuration
- `themes/` - Color schemes and visual themes
- `userprefs.conf` - Personal preferences

**Features:**
- Tiling window management with dynamic layouts
- Custom animations and visual effects
- Multi-monitor support with per-monitor configuration
- Extensive keybinding system for productivity
- Integrated with rofi, waybar, and other Wayland tools

#### `rc.lua.awesome` - AwesomeWM Configuration
- **Purpose:** Lua-based configuration for AwesomeWM (X11)
- **Features:** Tiling window manager setup with custom layouts and widgets
- **Size:** 35,502 lines of comprehensive window manager configuration

### 🌐 Applications

#### `config/qutebrowser/` - Keyboard-Driven Browser
- **Features:** Vim-like web browser with extensive customization
- **Configuration:** Python-based config with custom keybindings
- **Font:** Configured to use Hack Nerd Font family
- **Includes:** Bookmarks, search engines, and behavioral settings

#### `termite/` - Terminal Emulator (Legacy)
- **Purpose:** Lightweight VTE-based terminal configuration
- **Status:** Legacy support for older Linux systems

---

## 🔧 Setup Scripts

### `symlink-configs.sh` - Enhanced Dotfiles Installer ⭐
**Purpose:** Advanced symbolic link creator with date-stamped backups
- **Date-stamped backups** of existing configurations (`~/.config-backups/YYYYMMDD_HHMMSS/`)
- **Smart conflict resolution** with automatic backup detection
- **Interactive mode** for selective configuration linking
- **Comprehensive logging** with detailed operation reports
- **Platform detection** (macOS/Linux) with appropriate handling
- **Font installation** (Hack Nerd Font family)
- **Safety features** with dry-run mode and validation

**Usage Options:**
```bash
./symlink-configs.sh           # Full automatic setup
./symlink-configs.sh -i        # Interactive mode
./symlink-configs.sh --help    # Show all options
```

### `symdotfiles.sh` - Legacy Dotfiles Installer
**Purpose:** Original dotfiles installer (maintained for compatibility)
- Basic symbolic link creation
- Simple backup system (`.bak` files)
- Vim/Tmux plugin installation
- Links configs to `~/.dotfiles/` directory

### `new_mac_setup.sh` - macOS Environment Setup
**Capabilities:**
- Homebrew installation and package management
- macOS system preferences optimization
- Development tool installation (git, node, python, etc.)
- Application installation via Homebrew Cask
- Font installation (Hack Nerd Font)
- Shell configuration (zsh setup)

### `new_arch_setup.sh` - Arch Linux Environment Setup  
**Features:**
- Package manager setup (pacman, yay)
- Essential package installation
- AUR helper installation
- Development environment setup
- Font installation via package manager
- Display manager and desktop environment setup

### `probhat_key_layout_mac.sh` - Bengali Keyboard Layout
**Purpose:** Custom Bengali (Probhat) keyboard layout installer for macOS
- Installs custom keyboard layout
- Configures input method switching
- Provides Bengali typing support

---

## 🎨 Utilities & Scripts

### `scripts/` Directory (14 utilities)

**System Utilities:**
- `battery_status.sh` - Battery status notifications
- `list_terminals.sh` - Available terminal emulators scanner  
- `list_updates.sh` - System update checker for multiple package managers

**Productivity Tools:**
- `daily_notes.sh` - Daily note-taking automation
- `notes.sh` - Quick note creation and management
- `youtube-mp3-rofi.sh/.py` - YouTube audio downloader with rofi interface

**Development Tools:**
- `zoxide_tmux.sh` - Smart directory navigation for tmux
- `zoxide_zellij.sh` - Smart directory navigation for zellij

**Specialized Scripts:**
- `prothom-alo.py` - Bengali news aggregator
- `raj.py` - Custom automation script
- `tor-1337.py` - Tor network utility

### Additional Utilities

#### `check.sh` - Font Verification
Tests powerline/nerd font installation and display capabilities

#### `bad_zsh_history_fix.sh` - ZSH History Repair
Repairs corrupted zsh history files

#### `convert.sh` - File Conversion Utility
General-purpose file format conversion tool

---

## 📦 Dependencies

### Required Fonts
- **[Hack Nerd Font](https://nerdfonts.com)** - Included in `Hack/` directory
  - Complete Nerd Font family with icon support
  - Used by terminal emulators and applications
  - Essential for proper display of icons and symbols

### Core Dependencies
- **Shell:** `zsh` with `oh-my-zsh` framework
- **Prompt:** `starship` cross-shell prompt
- **Multiplexer:** `tmux` for terminal session management
- **Editor:** `neovim` (primary) with `lua` support
- **Fuzzy Finder:** `fzf` for file and command searching
- **Version Control:** `git` with enhanced configurations

### Platform-Specific
**macOS:**
- Homebrew package manager
- iTerm2 or similar terminal emulator
- Ghostty terminal (optional)

**Linux (Arch):**
- Pacman package manager + AUR helper (yay)
- Hyprland compositor (Wayland)
- Various Wayland tools (rofi, waybar, etc.)

---

## 🔄 Installation Methods

### Method 1: Full Environment Setup
```bash
# macOS
curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/new_mac_setup.sh | sh

# Arch Linux  
curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/new_arch_setup.sh | sh
```

### Method 2: Dotfiles Only
```bash
curl -fsSL https://raw.githubusercontent.com/mjonyh/config/master/symdotfiles.sh | sh
```

### Method 3: Manual Installation
```bash
git clone https://github.com/mjonyh/config.git ~/.dotfiles
cd ~/.dotfiles
./symdotfiles.sh
```

### Method 4: Selective Installation
```bash
git clone https://github.com/mjonyh/config.git
# Copy individual config files as needed
```

---

## 📚 Documentation

- **[Cleanup Log](copilot_1.md)** - Recent repository cleanup and organization details
- **[AI Guidelines](CLAUDE.md)** - Instructions for AI assistants working with this repository
- **[Screenshots](screenshots/)** - Visual previews of configurations in action

---

## 📄 License

This repository is open source and available under the [MIT License](LICENSE).

---

## 🤝 Contributing

Feel free to fork this repository and adapt the configurations for your own use. If you have improvements or suggestions, pull requests are welcome!

**Note:** These are personal configurations optimized for my workflow. You may need to modify them for your specific needs and preferences. 
