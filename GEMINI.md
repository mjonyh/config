# Gemini Project Context: Unified Development Environment Dotfiles

This document provides context for the `mjonyh/config` repository, a collection of dotfiles for creating a unified development environment across Linux and macOS.

## Project Overview

This is a **non-code project** consisting of configuration files (dotfiles) for various development tools. The goal is to provide a consistent and professional setup for Zsh, Neovim, Tmux, and other tools, with a focus on performance, aesthetics, and productivity. The project is designed to be cross-platform, with support for both macOS and Arch Linux.

### Key Features:

*   **Cross-Platform:** Works on macOS (using Homebrew) and Arch Linux (using Pacman).
*   **Unified Installer:** A single `install.sh` script handles the entire setup process.
*   **Robust Symlinking:** The `symlink-config.sh` script safely links configurations and creates backups of existing files.
*   **Performance:** Optimized Zsh configuration for fast startup.
*   **Aesthetics:** Consistent Catppuccin theming across all tools.

## Directory Overview

The repository is structured as follows:

*   `install.sh`: The main installation script.
*   `symlink-config.sh`: The script for creating symbolic links to the configuration files.
*   `scripts/`: A collection of helper scripts for tasks like package installation, system setup, and more.
*   `config/`: Configuration files for various tools like `qutebrowser` and `wofi`.
*   `nvim/`: A modern Neovim configuration written in Lua, using `lazy.nvim` for plugin management.
*   `hypr/`: Configuration for the Hyprland Wayland compositor.
*   `zshrc`: The configuration file for the Zsh shell.
*   `tmux.conf`: The configuration file for the Tmux terminal multiplexer.
*   `docs/`: Additional documentation and guides.

## Usage

The primary way to use this repository is to run the `install.sh` script, which will install the necessary packages and symlink the configuration files to their correct locations.

### Building and Running

This is a non-code project, so there is no build process. The main actions are:

*   **Installation:**
    ```bash
    ./install.sh
    ```
    The installer has modular options:
    *   `--install-packages`: Installs system packages only.
    *   `--setup-system`: Configures system settings.
    *   `--symlink-only`: Creates symbolic links for the configuration files.

*   **Neovim:** The Neovim configuration is located in the `nvim/` directory. The entry point is `init.lua`, which loads the rest of the configuration from the `lua/` directory. Key plugins are managed with `lazy.nvim`.

*   **Hyprland:** The Hyprland configuration is in the `hypr/` directory. The main configuration file is `hyprland.conf`, which sources other files for themes, keybindings, and window rules.

## Development Conventions

*   **Modularity:** The configurations for Neovim and Hyprland are broken down into smaller, more manageable files.
*   **Shell Scripting:** The installation and setup scripts are written in Bash and are well-documented.
*   **Theming:** The Catppuccin theme is used consistently across all tools.
