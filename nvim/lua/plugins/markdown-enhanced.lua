-- Enhanced Markdown Workflow with PDF Support
return {
  -- Enhanced Markdown Preview with Live Reload
  {
    'iamcco/markdown-preview.nvim',
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    keys = {
      {
        "<leader>mp",
        "<cmd>MarkdownPreviewToggle<cr>",
        desc = "Markdown Preview Toggle",
      },
    },
    config = function()
      vim.cmd([[
        function OpenMarkdownPreview (url)
          execute "silent ! open -a 'Google Chrome' " . a:url
        endfunction
        let g:mkdp_browserfunc = 'OpenMarkdownPreview'
      ]])
      
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ""
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
    end,
  },

  -- Advanced PDF Generation with Pandoc
  {
    'davidgranstrom/nvim-markdown-preview',
    ft = "markdown",
    cmd = "MarkdownPreview",
    keys = {
      {
        "<leader>mdp",
        "<cmd>MarkdownPreview<cr>",
        desc = "Markdown PDF Preview",
      },
    },
  },

  -- Markdown Table Mode for Easy Table Creation
  {
    'dhruvasagar/vim-table-mode',
    ft = "markdown",
    keys = {
      {
        "<leader>tm",
        "<cmd>TableModeToggle<cr>",
        desc = "Toggle Table Mode",
      },
    },
    config = function()
      vim.g.table_mode_corner = '|'
      vim.g.table_mode_corner_corner = '+'
      vim.g.table_mode_header_fillchar = '='
    end,
  },

  -- Enhanced Markdown Folding
  {
    'masukomi/vim-markdown-folding',
    ft = "markdown",
  },

  -- Markdown Link Utilities
  {
    'jakewvincent/mkdnflow.nvim',
    ft = "markdown",
    config = function()
      require('mkdnflow').setup({
        modules = {
          bib = true,
          buffers = true,
          conceal = true,
          cursor = true,
          folds = false,
          links = true,
          lists = true,
          maps = true,
          paths = true,
          tables = true,
          yaml = false
        },
        filetypes = {md = true, rmd = true, markdown = true},
        create_dirs = true,
        perspective = {
          priority = 'first',
          fallback = 'current',
          root_tell = false,
          nvim_wd_heel = false,
          update = false
        },
        wrap = false,
        bib = {
          default_path = nil,
          find_in_root = true
        },
        silent = false,
        links = {
          style = 'markdown',
          name_is_source = false,
          conceal = false,
          context = 0,
          implicit_extension = nil,
          transform_implicit = false,
          transform_explicit = function(text)
            text = text:gsub(" ", "-")
            text = text:lower()
            text = os.date('%Y-%m-%d_')..text
            return(text)
          end
        },
        new_file_template = {
          use_template = false,
          placeholders = {
            before = {
              title = "link_title",
              date = "os_date"
            },
            after = {}
          },
          template = "# {{ title }}"
        },
        to_do = {
          symbols = {' ', '-', 'X'},
          update_parents = true,
          not_started = ' ',
          in_progress = '-',
          complete = 'X'
        },
        tables = {
          trim_whitespace = true,
          format_on_move = true,
          auto_extend_rows = false,
          auto_extend_cols = false
        },
        yaml = {
          bib = { override = false }
        },
        mappings = {
          MkdnEnter = {{'n', 'v'}, '<CR>'},
          MkdnTab = false,
          MkdnSTab = false,
          MkdnNextLink = {'n', '<Tab>'},
          MkdnPrevLink = {'n', '<S-Tab>'},
          MkdnNextHeading = {'n', ']]'},
          MkdnPrevHeading = {'n', '[['},
          MkdnGoBack = {'n', '<BS>'},
          MkdnGoForward = {'n', '<Del>'},
          MkdnCreateLink = false, -- see MkdnEnter
          MkdnCreateLinkFromClipboard = {{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
          MkdnFollowLink = false, -- see MkdnEnter
          MkdnDestroyLink = {'n', '<M-CR>'},
          MkdnTagSpan = {'v', '<M-CR>'},
          MkdnMoveSource = {'n', '<F2>'},
          MkdnYankAnchorLink = {'n', 'yaa'},
          MkdnYankFileAnchorLink = {'n', 'yfa'},
          MkdnIncreaseHeading = {'n', '+'},
          MkdnDecreaseHeading = {'n', '-'},
          MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
          MkdnNewListItem = false,
          MkdnNewListItemBelowInsert = {'n', 'o'},
          MkdnNewListItemAboveInsert = {'n', 'O'},
          MkdnExtendList = false,
          MkdnUpdateNumbering = {'n', '<leader>nn'},
          MkdnTableNextCell = {'i', '<Tab>'},
          MkdnTablePrevCell = {'i', '<S-Tab>'},
          MkdnTableNextRow = false,
          MkdnTablePrevRow = {'i', '<M-CR>'},
          MkdnTableNewRowBelow = {'n', '<leader>ir'},
          MkdnTableNewRowAbove = {'n', '<leader>iR'},
          MkdnTableNewColAfter = {'n', '<leader>ic'},
          MkdnTableNewColBefore = {'n', '<leader>iC'},
          MkdnFoldSection = {'n', '<leader>f'},
          MkdnUnfoldSection = {'n', '<leader>F'},
        }
      })
    end,
  },
}