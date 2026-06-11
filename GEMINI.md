# Gemini Project Context: Unified Development Environment Dotfiles

This document provides context for the `mjonyh/config` repository, a collection of dotfiles for creating a unified development environment across macOS and Linux.

## Project Overview

This is a **non-code project** consisting of configuration files (dotfiles) for various development tools. The goal is to provide a consistent and professional setup for Zsh, Neovim, Tmux, and other tools, with a focus on performance, aesthetics, and productivity.

### Key Features

- **Cross-Platform:** Works on **macOS** (Homebrew) and **Linux** — Arch (Pacman), Debian (apt).
- **Unified Installer:** A single `install.sh` script handles the entire setup process.
- **Robust Symlinking:** The `symlink-config.sh` script safely links configurations and creates backups of existing files.
- **Performance:** Optimized Zsh configuration with lazy-loading plugins for fast startup.
- **Aesthetics:** Consistent Catppuccin theming across all tools.

## Directory Overview

| Path | Description | Platform |
|------|-------------|----------|
| `install.sh` | Master installation script | All |
| `symlink-config.sh` | Dotfile linker with backup support | All |
| `CLAUDE.md` | Claude Code AI guidance | All |
| `GEMINI.md` | This file | All |
| `GPU_driver_information` | GPU/driver notes per machine | All |
| `README.md` | Main documentation | All |
| `todo.txt` | Pending tasks / tool wishlist | All |
| `starship.toml` | Starship prompt config | All |
| `zshrc` | Zsh configuration | All |
| `vimrc` | Vim/Neovim fallback config | All |
| `tmux.conf` | Tmux configuration | All |
| `catppuccin-mocha-exa.conf` | Catppuccin colors for exa/eza | All |
| `keybindings_tmux.md` | Tmux keybindings cheat sheet | All |
| `rc.lua.awesome` | AwesomeWM configuration | Linux |
| `rc.lua.termit` | Termit configuration (legacy) | Linux |
| `nvim/` | Neovim Lua configuration | All |
| `hypr/` | Hyprland Wayland compositor config | Linux |
| `ghostty/` | Ghostty terminal config | All |
| `termite/` | Termite terminal config | Linux |
| `config/` | App-specific configs (kitty, qutebrowser, dunst, waybar, wofi) | Linux |
| `Hack/` | Hack Nerd Font files | All |
| `scripts/` | Utility and helper scripts | All |
| `docs/` | Documentation and guides | All |
| `screenshots/` | README screenshots | All |
| `tmuxp/` | Tmux session profiles | All |
| `src/` | Shell source additions | All |

## Usage

The primary way to use this repository is to run the `install.sh` script, which will install the necessary packages and symlink the configuration files to their correct locations.

### Installation

```bash
./install.sh
```

The installer has modular options:
- `--install-packages`: Installs system packages only.
- `--setup-system`: Configures system settings.
- `--symlink-only`: Creates symbolic links for the configuration files.
- `--all`: Full installation (default).

### Symlink Management

```bash
./symlink-config.sh install   # Create all symlinks with backup
./symlink-config.sh revert    # Restore original files and remove symlinks
./symlink-config.sh status    # Check current symlink status
```

Backups are stored in `~/.config-backup/` with timestamps.

## Platform-Specific Notes

### macOS
- Package manager: **Homebrew**
- Terminal: iTerm2 (primary), Ghostty
- GPU: Intel integrated graphics
- Fonts: Install via `brew install --cask font-hack-nerd-font`

### Arch Linux
- Package manager: **Pacman** + **Yay** (AUR)
- Window Manager: Hyprland (Wayland) or AwesomeWM (X11)
- Notifications: dunst
- Status Bar: waybar
- Application Launcher: wofi
- Wallpaper: swww
- GPU: NVIDIA (driver version in `GPU_driver_information`)

## Development Conventions

- **Modularity:** Configurations for Neovim and Hyprland are broken down into smaller, manageable files.
- **Shell Scripting:** Installation and setup scripts are written in Bash and are well-documented.
- **Theming:** The Catppuccin Mocha/Macchiato theme is used consistently across all tools.
- **OS Guards:** All OS-specific code checks `$(uname)` or `$OSTYPE` before executing.
