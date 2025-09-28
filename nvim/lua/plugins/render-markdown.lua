return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 
      'nvim-treesitter/nvim-treesitter', 
      'nvim-tree/nvim-web-devicons' -- Use consistent icons with your setup
    },
    ft = "markdown",
    keys = {
      {
        "<leader>mr",
        "<cmd>RenderMarkdown toggle<cr>",
        desc = "Toggle Markdown Rendering",
      },
    },
    config = function()
      require('render-markdown').setup({
        -- Heading configurations with beautiful icons
        headings = {'󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 '},
        -- Code block styling
        code = {
          enabled = true,
          sign = true,
          style = 'full', -- Shows language icons and names
          left_pad = 0,
          right_pad = 0,
          width = 'full',
          border = 'thin',
        },
        -- Beautiful bullet points
        bullet = {
          enabled = true,
          icons = { '●', '○', '◆', '◇' },
          left_pad = 0,
          right_pad = 0,
          highlight = 'RenderMarkdownBullet',
        },
        -- Enhanced checkbox rendering
        checkbox = {
          enabled = true,
          unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
          },
          checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
          },
        },
        -- Table rendering
        pipe_table = {
          enabled = true,
          style = 'full',
          cell = 'padded',
        },
        -- GitHub-style callouts
        callout = {
          note = { raw = '[!NOTE]', rendered = '󰋽 Note', highlight = 'RenderMarkdownInfo' },
          tip = { raw = '[!TIP]', rendered = '󰌶 Tip', highlight = 'RenderMarkdownSuccess' },
          important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint' },
          warning = { raw = '[!WARNING]', rendered = '󰀪 Warning', highlight = 'RenderMarkdownWarn' },
          caution = { raw = '[!CAUTION]', rendered = '󰳦 Caution', highlight = 'RenderMarkdownError' },
        },
      })
    end,
}
