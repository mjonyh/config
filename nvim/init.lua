require("config.lazy")
require("config.maps")
require("config.settings")


-- Catppuccin Mocha Setup
require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme "catppuccin"
