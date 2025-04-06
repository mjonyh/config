# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Installation
- `./symdotfiles.sh` - Install/configure dotfiles
- `./nvim.sh` - Set up Neovim configuration
- `./new_mac_setup.sh` - Set up a new macOS environment

## Code Style Guidelines

### Shell Scripts
- Use 4-space indentation
- Variable names: lowercase_with_underscores
- Functions: Descriptive names with meaningful prefixes
- Error handling: Use if-statements with helpful error messages
- Use color-coded logging (INFO, WARNING, ERROR, SUCCESS)

### Lua (Neovim config)
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

When editing files, maintain consistency with existing code style. Follow the file organization patterns established in the repository.