return {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.integrations"] = {},
                ["core.ui"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                    },
                },
                ["core.keybinds"] = {
                    config = {
                        -- Disable default keybindings to prevent conflicts
                        default_keybinds = false,
                        -- Set up custom keybinds that don't conflict
                        neorg_leader = "<Leader>n",
                    },
                },
                ["core.concealer"] = {
                    config = {
                        icon_preset = "basic",
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
            },
        })

        -- Custom keybindings for Neorg to avoid conflicts
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "norg",
            callback = function()
                local opts = { buffer = true, silent = true }
                
                -- Neorg-specific keybindings with <leader>n prefix to avoid conflicts
                vim.keymap.set("n", "<leader>nw", ":Neorg workspace notes<CR>", opts)
                vim.keymap.set("n", "<leader>nr", ":Neorg return<CR>", opts)
                vim.keymap.set("n", "<leader>nc", ":Neorg toggle-concealer<CR>", opts)
                
                -- Task management
                vim.keymap.set("n", "<leader>nt", ":Neorg keybind norg core.qol.todo_items.todo.task_cycle<CR>", opts)
                vim.keymap.set("n", "<leader>nd", ":Neorg keybind norg core.qol.todo_items.todo.task_done<CR>", opts)
                vim.keymap.set("n", "<leader>nu", ":Neorg keybind norg core.qol.todo_items.todo.task_undone<CR>", opts)
                vim.keymap.set("n", "<leader>np", ":Neorg keybind norg core.qol.todo_items.todo.task_pending<CR>", opts)
                vim.keymap.set("n", "<leader>nh", ":Neorg keybind norg core.qol.todo_items.todo.task_hold<CR>", opts)
                vim.keymap.set("n", "<leader>nx", ":Neorg keybind norg core.qol.todo_items.todo.task_cancelled<CR>", opts)
                vim.keymap.set("n", "<leader>ni", ":Neorg keybind norg core.qol.todo_items.todo.task_important<CR>", opts)
                
                -- Link management
                vim.keymap.set("n", "<leader>nl", ":Neorg keybind norg core.esupports.hop.hop-link<CR>", opts)
                vim.keymap.set("n", "<leader>nL", ":Neorg keybind norg core.esupports.hop.hop-link vsplit<CR>", opts)
                
                -- List management
                vim.keymap.set("n", "<leader>nlt", ":Neorg keybind norg core.promo.promote<CR>", opts)
                vim.keymap.set("n", "<leader>nld", ":Neorg keybind norg core.promo.demote<CR>", opts)
                
                -- Insert mode mappings
                vim.keymap.set("i", "<C-l>", function()
                    return require("neorg.modules.core.keybinds.module").public.remap_event("core.promo.promote")
                end, opts)
                vim.keymap.set("i", "<C-h>", function()
                    return require("neorg.modules.core.keybinds.module").public.remap_event("core.promo.demote")
                end, opts)
            end,
        })
    end,
}
