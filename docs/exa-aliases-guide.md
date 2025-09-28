# EXA Aliases Guide

Your zshrc now includes powerful exa aliases that replace traditional `ls` commands with modern features.

## Basic Aliases (exa replacements)

| Alias | Command | Description |
|-------|---------|-------------|
| `ls` | `exa --color=auto --group-directories-first` | Basic listing with colors |
| `ll` | `exa -l --icons --git --group-directories-first` | Long format with icons & git status |
| `la` | `exa -la --icons --git --group-directories-first` | All files (including hidden) |
| `l` | `exa -F --color=auto --group-directories-first` | Simple listing with file type indicators |

## Tree View Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `lt` | `exa --tree --level=2 --icons` | Tree view (2 levels deep) |
| `llt` | `exa -l --tree --level=2 --icons --git` | Long tree view with details |
| `tree` | `exa --tree --icons --git` | Full tree view |

## Power User Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `lx` | `exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons` | Ultimate detailed listing |
| `lS` | `exa -1 --icons --git --group-directories-first` | Single column view |
| `lr` | `exa -R --icons --git --group-directories-first` | Recursive listing |
| `lg` | `exa -l --git --git-ignore --icons --group-directories-first` | Git-focused listing |

## Smart Sorting Aliases (optimized version only)

| Alias | Command | Description |
|-------|---------|-------------|
| `recent` | `exa -l --sort=modified --reverse --icons --git` | Recently modified files first |
| `largest` | `exa -l --sort=size --reverse --icons --git` | Largest files first |

## EXA Features You Get

- 🎨 **Colors**: Automatic syntax highlighting
- 🎯 **Icons**: File type icons (with Nerd Fonts)  
- 📁 **Directory grouping**: Directories listed first
- 🔀 **Git integration**: Shows git status for each file
- 📊 **Smart sorting**: Various sorting options
- 🌳 **Tree view**: Visual directory structure
- ⚡ **Performance**: Faster than traditional ls
- 📅 **Time formats**: Multiple timestamp styles

## Installation Requirements

```bash
# Install exa (if not already installed)
brew install exa  # macOS
sudo apt install exa  # Ubuntu
```

## Notes

- All aliases include fallbacks to traditional `ls` if exa is not available
- Icons require a Nerd Font (Hack Nerd Font is included in this repo)
- Git status integration works in git repositories
- Performance is optimized for daily use

Try these commands to see the difference:
```bash
ll          # Beautiful long listing with icons
lt          # Tree view of current directory  
lg          # See git status integrated with file listing
recent      # Find recently modified files quickly
```
