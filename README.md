![Repository Size](https://img.shields.io/github/repo-size/mjonyh/config)
![Last Commit](https://img.shields.io/github/last-commit/mjonyh/config)
![License](https://img.shields.io/github/license/mjonyh/config)

# Unified Development Environment

A professional, cross-platform configuration suite for **Linux** and **macOS**. This repository provides a unified Setup for Zsh, Neovim, Tmux, and other development tools, designed for performance, aesthetics, and productivity.

## 📸 Screenshots

| Shell (ZSH + Starship)      | Neovim (Lua Config)         | Tmux Sessions                 |
| --------------------------- | --------------------------- | ----------------------------- |
| ![zsh](screenshots/zsh.png) | ![vim](screenshots/vim.png) | ![tmux](screenshots/tmux.png) |

---

## 🚀 Quick Start

One script to rule them all. Detects your OS and installs the appropriate packages and configurations.

```bash
git clone https://github.com/mjonyh/config.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

### Installation Options

The `install.sh` script is modular. You can run specific parts of the setup:

```bash
./install.sh --install-packages   # Only install system packages (Homebrew/Pacman)
./install.sh --setup-system       # Only configure system settings (Shell, Git, Defaults)
./install.sh --symlink-only       # Only link dotfiles (Safely backs up existing config)
./install.sh --all                # Run full installation (Default)
```

---

## 🛠️ Key Features

- **Cross-Platform**: Seamlessly works on **macOS** (Homebrew) and **Arch Linux** (Pacman + Yay).
- **Unified Installer**: A single entry point `install.sh` that delegates to OS-specific logic.
- **Robust Symlinking**: The `symlink-config.sh` utility safely links configurations, automatically creating timestamped backups of any existing files to `~/.config-backup/`.
- **Performance**: Optimized Zsh configuration with lazy-loading plugins and fast startup.
- **Aesthetics**: Consistent **Catppuccin** theming across Zsh, Tmux, Neovim, and system tools.

---

## 🧩 Configuration Modules

### 🐚 Shell (Zsh + Starship)
- **Fast Startup**: Optimized `zshrc` with distinct "fast mode" and "plugin mode".
- **Prompt**: Blazing fast **Starship** prompt written in Rust.
- **Plugins**: Essential tools like `zsh-autosuggestions` and `zsh-syntax-highlighting`.

### 📝 Neovim (Lua)
- **Modern**: Fully Lua-based configuration in `nvim/`.
- **Lazy.nvim**: Fast plugin management.
- **LSP & Treesitter**: Full IDE capabilities with intelligent code analysis.
- **Files**: `init.lua` entry point with modular `lua/config/` structure.

### 🖥️ Tmux
- **Productivity**: Custom keybindings matching Vim navigation (`h/j/k/l`).
- **Session Management**: Session persistence and easy switching.
- **Theme**: Catppuccin Macchiato integration for a seamless look.

### 🪟 Window Managers (Linux)
- **Hyprland**: Modern Wayland compositor configuration in `hypr/`.
- **AwesomeWM**: Lua-based configuration in `rc.lua.awesome`.

---

## 📂 Repository Structure

```
├── install.sh              # Master installation script
├── symlink-config.sh       # Dotfile linker with backup support
├── scripts/
│   ├── install_packages.sh # OS-specific package installation
│   ├── setup_system.sh     # System preference configuration
│   ├── check_fonts.sh      # Font capability verifier
│   └── common_utils.sh     # Shared logic and logging
├── config/                 # Configurations for Ghostty, etc.
├── nvim/                   # Neovim configuration
├── zshrc                   # Zsh configuration
├── tmux.conf               # Tmux configuration
└── doc/                    # Documentation and legacy scripts
```

## 🔧 Utilities

This repository includes a suite of helper scripts in `scripts/`:

- `check_fonts.sh`: Verify your terminal supports Nerd Fonts and Powerline symbols.
- `zsh_perf_test.sh`: Benchmark shell startup time.
- `daily_notes.sh`: Automation for daily journaling.
- `battery_status.sh`: Status bar component.

And many more.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
