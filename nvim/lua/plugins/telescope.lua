return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                              , branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()

		require('telescope').setup{
		  defaults = {
		    -- Default configuration for telescope goes here:
		    -- config_key = value,
		    mappings = {
		      i = {
			-- map actions.which_key to <C-h> (default: <C-/>)
			-- actions.which_key shows the mappings for your picker,
			-- e.g. git_{create, delete, ...}_branch for the git_branches picker
			["<C-h>"] = "which_key"
		      }
		    }
		  },
		  pickers = {
		    -- Default configuration for builtin pickers goes here:
		    -- picker_name = {
		    --   picker_config_key = value,
		    --   ...
		    -- }
		    -- Now the picker_config_key will be applied every time you call this
		    -- builtin picker
		  },
		  extensions = {
		    -- Your extension configuration goes here:
		    -- extension_name = {
		    --   extension_config_key = value,
		    -- }
		    -- please take a look at the readme of the extension you want to configure
		  }
		}

                -- set keymaps
                local keymap = vim.keymap

                keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
                keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find recent files" })
                keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find string in cwd" })
                keymap.set("n", "<leader>fs", "<cmd>Telescope git_status<cr>", { desc = "Find string under cursor in cwd" })
                keymap.set("n", "<leader>fc", "<cmd>Telescope git commits<cr>", { desc = "Find todos" })
        end,
    }
