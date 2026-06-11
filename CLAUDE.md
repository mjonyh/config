# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Installation
- `./symlink-config.sh install` - Install/configure dotfiles (recommended). Creates symlinks with automatic backups to `~/.config-backup/`.
- `./install.sh` - Full system setup (packages + system config + symlinks).
- `./install.sh --help` - See all installation options.

## Supported Platforms
- **macOS** (Homebrew)
- **Arch Linux** (Pacman + Yay)
- **Debian/Ubuntu** (apt, basic support)

Configurations are shared where possible and OS-specific where needed. Conditional logic is handled by checking `$(uname)` and `$OSTYPE`.

## Repository Scope

This is a **dotfiles / configuration** repository. It contains:
- Shell configs (zshrc, vimrc, tmux.conf, starship.toml)
- Editor configs (Neovim Lua config in `nvim/`)
- Terminal configs (Ghostty, Termite, Kitty)
- Window manager configs (Hyprland in `hypr/`, AwesomeWM in `rc.lua.awesome`)
- Utility scripts (in `scripts/`)
- Fonts (Hack Nerd Font in `Hack/`)
- tmuxp session profiles (in `tmuxp/`)
- Documentation (in `docs/`)

## Code Style Guidelines

### Shell Scripts
- Use 4-space indentation
- Variable names: lowercase_with_underscores
- Functions: Descriptive names with meaningful prefixes
- Error handling: Use if-statements with helpful error messages
- Use color-coded logging (INFO, WARNING, ERROR, SUCCESS)
- Guard OS-specific code with `if [[ "$(uname)" == "Darwin" ]]` / `elif [[ "$(uname)" == "Linux" ]]`

### Lua (Neovim / AwesomeWM config)
- Use 2-space indentation
- Variable names: snake_case
- Modules: Single responsibility pattern in separate files
- Imports: Simple require() statements

### Python Scripts
- Use 4-space indentation
- Variable names: snake_case
- Imports: Standard library first, then third-party, then local
- Error handling: Use try/except blocks
- String formatting: f-strings preferred

### Tmux Config
- Use Catppuccin Macchiato theme tokens (`@thm_*`)
- Prefix: `Ctrl-a`
- All custom bindings should have comments explaining purpose
- Minimize external shell calls in status bar (battery drain on laptops)

### Markdown
- Use ATX-style headers (`#`, `##`)
- Tables for structured comparisons
- Code blocks with language annotations

When editing files, maintain consistency with existing code style. Follow the file organization patterns established in the repository. When adding new configs, note which platform(s) they apply to.
