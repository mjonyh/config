local global = vim.g
local o = vim.opt

o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.syntax = "on"
o.autoindent = true
o.cursorline = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.encoding = "UTF-8"
o.ruler = true
-- o.mouse = "a"
o.title = true
o.hidden = true
o.ttimeoutlen = 0
o.wildmenu = true
o.showcmd = true
o.showmatch = true
o.inccommand = "split"
o.splitright = true
o.splitbelow = true
o.termguicolors = true
o.undofile = true
o.undodir = vim.fn.stdpath("data") .. "/undodir"
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.smartindent = true
-- o.wrap = false

vim.o.textwidth = 0
vim.o.wrapmargin = 0
-- visual wrap (no real line cutting is made)
vim.o.wrap = true
vim.o.linebreak = true -- breaks by word rather than character

vim.api.nvim_set_hl(0, "Normal", {guibg=NONE, ctermbg=NONE})
vim.g.python3_host_prog = vim.fn.expand('~/.config/nvim/venv/bin/python')
