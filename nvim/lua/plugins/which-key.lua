return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function()
    local wk = require("which-key")
    
    -- Register Neorg keybinding descriptions
    wk.add({
      { "<leader>n", group = "Neorg" },
      { "<leader>nw", desc = "Open notes workspace" },
      { "<leader>nr", desc = "Return from Neorg" },
      { "<leader>nc", desc = "Toggle concealer" },
      { "<leader>nt", desc = "Cycle task status" },
      { "<leader>nd", desc = "Mark task done" },
      { "<leader>nu", desc = "Mark task undone" },
      { "<leader>np", desc = "Mark task pending" },
      { "<leader>nh", desc = "Mark task on hold" },
      { "<leader>nx", desc = "Cancel task" },
      { "<leader>ni", desc = "Mark task important" },
      { "<leader>nl", desc = "Follow link" },
      { "<leader>nL", desc = "Follow link (vsplit)" },
      { "<leader>nl", group = "List management" },
      { "<leader>nlt", desc = "Promote list item" },
      { "<leader>nld", desc = "Demote list item" },
    })
  end,
}
