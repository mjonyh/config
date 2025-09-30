vim.g.mapleader = " "

local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Save
map("n", "<leader>w", "<CMD>update<CR>")

-- Save and Quit
map("n", "<leader>x", "<CMD>x<CR>")

-- Quit
map("n", "<leader>q", "<CMD>q<CR>")

-- Exit insert mode
map("i", "jk", "<ESC>")

-- NeoTree
map("n", "<leader>e", "<CMD>Neotree toggle<CR>")
-- map("n", "<leader>r", "<CMD>Neotree focus<CR>")

-- New Windows
map("n", "<leader>o", "<CMD>vsplit<CR>")
map("n", "<leader>p", "<CMD>split<CR>")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- Run python code
map("n", "<leader>rp", ":w<CR><CMD>!python3 %<CR>")

-- Disable arrows keys
map("n", "<Up>", "dd2kp")
map("n", "<Down>", "ddp")
map("n", "<Left>", "<Nop>")
map("n", "<Right>", "<Nop>")

map("i", "<Up>", "<Esc>dd2kpi")
map("i", "<Down>", "<Esc>ddpi")
map("i", "<Left>", "<Nop>")
map("i", "<Right>", "<Nop>")

map("v", "<Up>", "<Nop>")
map("v", "<Down>", "<Nop>")
map("v", "<Left>", "<Nop>")
map("v", "<Right>", "<Nop>")

-- Note: Neorg keybindings use <leader>n prefix to avoid conflicts
-- See lua/plugins/neorg.lua for Neorg-specific keybindings

