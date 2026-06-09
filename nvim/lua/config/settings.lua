-- Neovim base options and globals
-- This file sets up essential Neovim settings for the configuration.
-- It contains no LazyVim-specific settings (this is a plain lazy.nvim setup).

-- Global variables
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core Neovim options
local o = vim.opt

o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.autoindent = true
o.wrap = true
o.linebreak = true
o.scrolloff = 5
o.sidescrolloff = 5
o.cursorline = true
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.clipboard = "unnamedplus"
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.mouse = "a"
o.hidden = true
o.showmode = false
o.showcmd = true
o.wildmenu = true
o.completeopt = "menu,menuone,noselect"
o.updatetime = 250
o.timeoutlen = 300
o.signcolumn = "yes"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.list = false
o.conceallevel = 0
o.autoread = true
o.backup = false
o.writebackup = false
o.swapfile = false