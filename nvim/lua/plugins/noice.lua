return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      -- Configure cmdline to allow normal interaction
      cmdline = {
        enabled = true,
        view = "cmdline", -- Use normal cmdline instead of popup
      },
      -- Allow copying error messages and better message handling
      messages = {
        enabled = true,
        view = "notify", -- Show messages in notification area
        view_error = "notify", -- Show errors in notifications (copyable)
        view_warn = "notify",
        view_history = "messages",
        view_search = "virtualtext",
      },
      -- Configure popupmenu
      popupmenu = {
        enabled = true,
        backend = "nui",
      },
      -- Configure notifications
      notify = {
        enabled = true,
        view = "notify",
      },
      -- Less intrusive LSP
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = false, -- Reduce noise
        },
        signature = {
          enabled = false, -- Use default signature help
        },
        hover = {
          enabled = false, -- Use default hover
        },
      },
      -- Presets for better usability
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true, -- Long messages go to split (copyable)
        inc_rename = false,
        lsp_doc_border = false,
      },
      -- Routes to handle messages better
      routes = {
        -- Hide routine messages
        {
          filter = { event = "msg_show", find = "%d+B written" },
          opts = { skip = true },
        },
        {
          filter = { event = "msg_show", find = "%d+/%d+" },
          opts = { skip = true },
        },
        -- Ensure error messages are visible and copyable
        {
          filter = { event = "msg_show", kind = "error" },
          view = "notify",
        },
        -- Long messages to split (copyable)
        {
          filter = { event = "msg_show", min_height = 5 },
          view = "split",
        },
      },
    })
  end,
}

