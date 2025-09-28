![Repository Size](https://img.shields.io/github/repo-size/mjonyh/config)
![Last Commit](https://img.shields.io/github/last-commit/mjonyh/config)
![License](https://img.shields.io/github/license/mjonyh/config)

## 📸 Screenshots

| Shell (ZSH + Starship)      | Neovim (Lua Config)         | Tmux Sessions                 |
| --------------------------- | --------------------------- | ----------------------------- |
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

#### `zshrc` - ZSH Configuration ✅ **Optimized**
- **Status:** Clean, modern ZSH configuration with performance optimizations
- **Features:** 
  - Starship prompt integration
  - Essential plugins (syntax highlighting, autosuggestions)
  - Catppuccin Mocha color scheme for `exa`
  - Optimized aliases and functions
  - Fast startup time with selective plugin loading

#### `starship.toml` - Prompt Configuration
- **Purpose:** Modern, fast, and customizable prompt
- **Features:** Git integration, directory info, language detection
- **Theme:** Minimalist with essential information display

### 🖥️ Terminal Multiplexer

#### `tmux.conf` - Tmux Configuration
- **Purpose:** Enhanced terminal multiplexer setup
- **Features:** 
  - Custom key bindings for productivity
  - Status bar configuration
  - Session management
  - Integration with other tools

#### `tmuxp/` - Tmux Project Configurations
- **Purpose:** Pre-defined tmux session layouts
- **Features:** Project-specific window and pane configurations

### ✏️ Editor Configurations

#### `nvim/` - Neovim Configuration
- **Purpose:** Modern Lua-based Neovim setup
- **Features:**
  - LSP (Language Server Protocol) support
  - Syntax highlighting and completion
  - File explorer and fuzzy finding
  - Git integration
  - Plugin management with Lazy.nvim
  - Catppuccin theme integration

#### `vimrc` - Legacy Vim Configuration
- **Purpose:** Fallback Vim configuration
- **Status:** Basic setup for systems without Neovim

### 🎨 Color Schemes & Themes

#### `catppuccin-mocha-exa.conf` - Exa Color Configuration  
- **Purpose:** Catppuccin Mocha theme for `exa` file listings
- **Features:** Beautiful pastel colors for different file types

#### `test-catppuccin-colors.sh` - Color Testing Script
- **Purpose:** Test and preview Catppuccin colors in terminal

### 🤖 Window Managers

#### `hypr/` - Hyprland Configuration
- **Purpose:** Wayland compositor configuration
- **Features:** Modern tiling window manager setup

#### `rc.lua.awesome` - AwesomeWM Configuration  
- **Purpose:** Lua configuration for Awesome window manager

#### `ghostty/` - Ghostty Terminal Configuration
- **Purpose:** Configuration for Ghostty terminal emulator

### 📜 Setup Scripts

#### `new_mac_setup.sh` - macOS Setup Script
- **Purpose:** Automated macOS environment setup
- **Features:** Installs Homebrew, essential tools, and configures system

#### `new_arch_setup.sh` - Arch Linux Setup Script  
- **Purpose:** Automated Arch Linux environment setup
- **Features:** Package installation and system configuration

#### `symlink-configs.sh` - Configuration Linking Script
- **Purpose:** Creates symbolic links for all config files
- **Features:** 
  - Automatic backup of existing configs
  - Timestamp-based backup naming
  - Safe overwrite protection

#### `symdotfiles.sh` - Legacy Dotfiles Script
- **Purpose:** Original dotfiles setup script
- **Status:** Maintained for compatibility

### 🔧 Utility Scripts

#### `scripts/` - Utility Scripts Directory
- **Contents:**
  - `battery_status.sh` - Battery monitoring for status bars
  - `daily_notes.sh` - Daily note management system
  - `list_terminals.sh` - Terminal emulator detection
  - `list_updates.sh` - System update checker
  - `notes.sh` - General note-taking utility
  - `prothom-alo.py` - News aggregation script
  - `tor-1337.py` - Tor network utility
  - `youtube-mp3-rofi.py` - YouTube to MP3 converter with Rofi
  - `youtube-mp3-rofi.sh` - Shell wrapper for YouTube converter
  - `zoxide_tmux.sh` - Zoxide integration for Tmux
  - `zoxide_zellij.sh` - Zoxide integration for Zellij

#### `optimize-zshrc.sh` - ZSH Performance Optimizer
- **Purpose:** Optimize ZSH configuration for faster startup
- **Features:** Plugin management and performance testing

#### `install-zsh-essentials.sh` - ZSH Plugin Installer
- **Purpose:** Install essential ZSH plugins
- **Features:** Automated plugin installation and configuration
./optimize-zshrc.sh --test       # Compare performance before/after
```

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

**Purpose:** Advanced symbolic link creator with date-stamped backups and revert capability

- **Date-stamped backups** of existing configurations (`~/.config-backups/YYYYMMDD_HHMMSS/`)
- **Smart conflict resolution** with automatic backup detection
- **Interactive mode** for selective configuration linking
- **Comprehensive logging** with detailed operation reports
- **Platform detection** (macOS/Linux) with appropriate handling
- **Font installation** (Hack Nerd Font family)
- **Safety features** with dry-run mode and validation
- **🔄 Revert functionality** - safely undo all changes using backups

**Setup Usage:**

```bash
./symlink-configs.sh           # Full automatic setup
./symlink-configs.sh -i        # Interactive mode
./symlink-configs.sh --help    # Show all options
```

**Revert Usage:**

```bash
./symlink-configs.sh --revert        # Interactive revert (choose backup)
./symlink-configs.sh --revert-latest # Revert from most recent backup
./symlink-configs.sh --list-backups  # List available backups
./symlink-configs.sh --revert-from ~/.config-backups/20241228_143022  # Specific backup
```

**Revert Features:**

- 🛡️ **Safe revert** - Only removes symlinks created by this script
- 📋 **Interactive selection** - Choose which backup to restore from
- 🔍 **Backup validation** - Shows what will be restored before confirmation
- 📝 **Detailed logging** - All revert operations logged with timestamps
- 🎯 **Selective restoration** - Choose to keep or remove installed fonts
- ⚡ **Smart detection** - Skips files not managed by the script

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

### `scripts/` Directory (13 utilities)

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
- `tor-1337.py` - Tor network utility

### Additional Utilities

#### `exa-aliases-guide.md` - Modern File Listing Guide 📁

**Purpose:** Documentation for enhanced exa aliases that replace traditional `ls`

- **16 powerful aliases** using exa's modern features
- **Tree views:** `lt`, `llt`, `tree` for directory visualization
- **Git integration:** `lg` shows git status alongside file listings
- **Smart sorting:** `recent`, `largest` for quick file discovery
- **Fallback support** to traditional `ls` if exa unavailable

**Key Features:**

- 🎨 Colors and icons with Nerd Font support
- 📁 Directory-first grouping
- 🔀 Git status integration
- 🌳 Tree view capabilities
- ⚡ Performance optimized for daily use

#### `optimize-zshrc.sh` - ZSH Performance Optimizer ⚡

**Purpose:** Fixes slow ZSH startup times (reduces 34+ plugins to 6 essential ones)

- **Performance boost:** 50-80% faster shell startup times
- **Safety features:** Automatic backup with timestamped restore points
- **Smart optimization:** Lazy loading, conditional plugin loading, cached completions
- **Usage modes:** Fast mode (default) and full plugin mode (ZPLUG_ENABLE=1)

**Commands:**

```bash
./optimize-zshrc.sh --install    # Install optimized config (recommended)
./optimize-zshrc.sh --analyze    # Show current performance issues
./optimize-zshrc.sh --test       # Benchmark before/after performance
./optimize-zshrc.sh --revert     # Restore from backup
```

#### `zsh-performance-test.sh` - Shell Startup Benchmark

**Purpose:** Measures and compares ZSH startup performance

- Tests current vs optimized configuration
- 5-run average for accurate results
- Shows improvement percentage and millisecond reduction

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
