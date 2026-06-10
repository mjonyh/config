# Neovim Configuration Report

## Overview
This report covers the Neovim configuration located at `/Users/mjonyh/git/config/nvim`.
The config uses **lazy.nvim** as the plugin manager and is organized into a modular structure.

---

## Directory Structure

```
nvim/
├── init.lua                 # Main entry point
├── lazy-lock.json           # Plugin lockfile
├── lua/
│   └── config/
│       ├── settings.lua     # Global settings
│       ├── options.lua      # Vim options
│       ├── lazy.lua         # lazy.nvim bootstrap & setup
│       └── maps.lua         # Key mappings
└── lua/plugins/
    ├── cmp.lua              # Completion (nvim-cmp + LuaSnip)
    ├── lsp.lua              # LSP configuration (mason, lspconfig)
    ├── linting.lua          # Linting (nvim-lint)
    ├── formatting.lua       # Formatting (conform.nvim)
    ├── telescope.lua        # Telescope picker
    ├── fzf.lua              # FZF Lua integration
    ├── gitsigns.lua         # Git integration
    ├── treesitter.lua       # Tree-sitter parser
    ├── noice.lua            # (empty - referenced)
    ├── colorizer.lua        # Color preview
    ├── lualine.lua          # Status line
    ├── which-key.lua        # Keybinding hints
    ├── neotree.lua          # File explorer
    ├── vim-tmux-navigator.lua
    ├── autopairs.lua        # Auto-closing pairs
    ├── codeium.lua          # AI completion (codeium.vim)
    ├── lightspeed.lua       # Cursor movement speed
    ├── nvim-surround.lua    # Surround text objects
    ├── markdown-comprehensive.lua  # Markdown + PDF generation
    ├── markmap.lua          # Markdown mind maps
    ├── render-markdown.lua  # Markdown rendering
    ├── telescope-undo.lua   # Undo history browser
    ├── colorscheme.lua      # Catppuccin theme
    ├── snaks.lua            # Snacks.nvim suite
    └── neorg.lua            # Neorg note-taking
```

---

## Core Settings (options.lua)

### Editor Options
| Option | Value | Purpose |
|--------|-------|---------|
| `scrolloff` | 5 | Keep 5 lines visible when scrolling |
| `number` | true | Show line numbers |
| `relativenumber` | true | Relative line numbers |
| `clipboard` | unnamedplus | System clipboard integration |
| `syntax` | on | Syntax highlighting |
| `autoindent` | true | Auto-indentation |
| `cursorline` | true | Highlight current line |
| `expandtab` | true | Use spaces, not tabs |
| `shiftwidth` | 2 | Indent width |
| `tabstop` | 2 | Tab width |
| `encoding` | UTF-8 | File encoding |
| `termguicolors` | true | True-color support |
| `undofile` | true | Persistent undo |
| `wrap` | true | Soft wrap lines |
| `linebreak` | true | Wrap at word boundaries |

---

## Plugin Inventory

### Plugin Manager
- **lazy.nvim** — Plugin manager with auto-update checker

### LSP & Completion
| Plugin | Purpose |
|--------|---------|
| `nvim-cmp` | Completion engine |
| `cmp-buffer` | Buffer text source |
| `cmp-path` | Filesystem path source |
| `cmp-nvim-lsp` | LSP completion source |
| `LuaSnip` | Snippet engine |
| `cmp_luasnip` | Snippet completion integration |
| `lspkind.nvim` | VS Code-style pictograms |
| `nvim-lspconfig` | LSP server configurations |
| `mason.nvim` | LSP server installer |
| `mason-lspconfig.nvim` | Mason + LSP bridge |
| `mason-tool-installer.nvim` | Formatter/linter installer |
| `neodev.nvim` | LSP for Neovim config |
| `nvim-lsp-file-operations` | File operations via LSP |

**LSP Servers Installed**:
ts_ls, html, cssls, tailwindcss, svelte, lua_ls, graphql, emmet_ls, prismals, pyright

**Formatters/Linters Installed**: prettier, stylua, isort, black, pylint, eslint_d

### Editor Enhancements
| Plugin | Purpose |
|--------|---------|
| `nvim-treesitter` | Syntax tree parsing, highlighting, autotag |
| `windwp/nvim-ts-autotag` | Auto-close HTML/XML tags |
| `nvim-colorizer.lua` | Show hex/color codes |
| `nvim-autopairs` | Auto-close brackets, quotes, etc. |
| `nvim-surround` | Text surround operations (ds, cs, ys) |
| `lightspeed.nvim` | Faster cursor movement |
| `vim-tmux-navigator` | Navigate between tmux/neovim panes |

### Search & Navigation
| Plugin | Purpose |
|--------|---------|
| `telescope.nvim` | Fuzzy finder for files, grep, LSP |
| `fzf-lua` | FZF integration with previews |
| `telescope-undo.nvim` | Browse undo history |

### Git
| Plugin | Purpose |
|--------|---------|
| `gitsigns.nvim` | Git diff signs, blame, status |

### UI
| Plugin | Purpose |
|--------|---------|
| `lualine.nvim` | Status line (Eviline-style) |
| `which-key.nvim` | Keybinding hints popup |
| `catppuccin/nvim` | Colorscheme (mocha flavor) |
| `render-markdown.nvim` | Markdown rendering with icons |
| `noice.nvim` | Notification enhancement |
| `snacks.nvim` | Utility suite (zen, notify, etc.) |
| `nvim-neo-tree/neo-tree.nvim` | File explorer |
| `nvim-web-devicons` | File icons |

### Markdown & Notes
| Plugin | Purpose |
|--------|---------|
| `markdown-preview.nvim` | Live markdown preview |
| `markmap.nvim` | Markdown mind map generation |
| `render-markdown.nvim` | Enhanced markdown rendering |
| `nvim-neorg/neorg` | Note-taking system |
| `plenary.nvim` | Utility functions |

### AI
| Plugin | Purpose |
|--------|---------|
| `codeium.vim` | AI code completion |

### Other
| Plugin | Purpose |
|--------|---------|
| `friendly-snippets` | Snippet collection |

---

## Key Mappings Summary

### Leader: `<Space>`

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>x` | Save and quit |
| `<leader>q` | Quit |
| `<leader>e` | Toggle Neo-tree |
| `<leader>o` | Vertical split |
| `<leader>p` | Horizontal split |
| `<leader>rp` | Run Python file |
| `<leader>ff` | Telescope find files |
| `<leader>fg` | Telescope live grep |
| `<leader>fb` | Telescope buffers |
| `<leader>fs` | Telescope git status |
| `<leader>fc` | Telescope git commits |
| `<leader>D` | Diagnostics for file |
| `<leader>d` | Line diagnostics |
| `<leader>ca` | Code actions |
| `<leader>rn` | Smart rename |
| `<leader>l` | Trigger linting |
| `<leader>mp` | Format file |
| `<leader>pdf*` | Markdown to PDF (various themes) |
| `<leader>z` | Toggle zen mode |
| `<leader>Z` | Toggle zoom |
| `<leader>gg` | Lazygit |
| `<leader>u` | Telescope undo |
| `<leader>?` | Which-key help |
| `jk` | Exit insert mode |
| Arrow keys | Disabled |

---

## LSP Setup

LSPs are installed via **mason.nvim**. Key features:
- Auto-installation of LSP servers and tools
- Buffer-local keymaps on LSP attach:
  - `gR` — LSP references
  - `gd` — LSP definitions
  - `gD` — LSP declaration
  - `gi` — LSP implementations
  - `gt` — LSP type definitions
  - `K` — Hover documentation
  - `[d` / `]d` — Previous/next diagnostic
  - `<leader>ca` — Code actions
  - `<leader>rs` — Restart LSP

---

## Formatting & Linting

### Conform.nvim (formatting)
- Format on save enabled with `lsp_fallback`
- Supported formatters: prettier, stylua, isort, black, eslint_d, pylint
- Manual format: `<leader>mp`

### Nvim-lint (linting)
- eslint_d for JS/TS/Svelte
- pylint for Python
- Manual lint: `<leader>l`

---

## File Explorer: Neo-tree

- Sources: filesystem, buffers, git_status
- Key: `<leader>e` to toggle
- Git integration with status display
- Custom mappings: `Y` (copy path), `O` (open with system app), `P` (preview)

---

## Note-Taking: Neorg

- Workspace: `~/notes`
- Modules loaded: defaults, ui, dirman, keybinds, concealer, completion
- Key prefix: `<leader>n`
- Task management, link following, list promotion/demotion

---

## Markdown Workflow

### PDF Generation
- Uses pandoc + xelatex
- Multiple highlight styles: breezedark, kate, pygments, zenburn, espresso, tango, haddock, monochrome
- Auto-open on macOS
- Commands: `:MarkdownToPDF`, `:MarkdownToPDFDark`, `:MarkdownToPDFLight`

### Rendering
- `render-markdown.nvim`: enhanced checkboxes, callouts, tables, headings
- `markdown-preview.nvim`: live browser preview
- `markmap.nvim`: mind map generation

---

## Statistics

- **Total Plugins**: ~35
- **Lua Config Files**: 24
- **LSP Servers**: 10
- **Formatter/Linter Tools**: 6
- **Leader Key**: `<Space>`
- **Colorscheme**: Catppuccin Mocha
- **Plugin Manager**: lazy.nvim

---

## Summary

This is a feature-rich Neovim configuration focused on:
1. **Full LSP experience** — Multiple servers, mason auto-install, conform formatting
2. **Smart completion** — nvim-cmp + LuaSnip with multiple sources
3. **File navigation** — Telescope, fzf-lua, Neo-tree
4. **Git integration** — gitsigns, lazygit integration via snacks
5. **Markdown workflow** — Preview, PDF generation, mind maps, Neorg notes
6. **UI polish** — Catppuccin theme, lualine, which-key, snacks.nvim
7. **Productivity** — Auto-pairs, surround, lightspeed, disabled arrow keys
