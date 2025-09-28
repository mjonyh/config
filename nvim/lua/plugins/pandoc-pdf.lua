-- DISABLED: Professional PDF Generation with Pandoc (replaced with simple version)
-- This plugin was causing "file format pandoc not supported" errors
-- Replaced with simple reliable functions in markdown-pdf-simple.lua

return {}
    config = function()
      require('pandoc').setup({
        default = {
          output_dir = "output/",
          args = {
            {'-f', 'markdown'},
            {'-t', 'pdf'},
            {'--pdf-engine=xelatex'},
            {'--variable', 'geometry:margin=1in'},
            {'--variable', 'fontsize=12pt'},
            {'--variable', 'documentclass=article'},
            {'--variable', 'classoption=twocolumn'},
            {'--number-sections'},
            {'--table-of-contents'},
            {'--highlight-style=tango'},
            {'--standalone'}
          }
        },
        -- Custom commands for different PDF styles
        commands = {
          -- Academic Paper Style
          {
            name = "academic",
            args = {
              {'-f', 'markdown+citations'},
              {'-t', 'pdf'},
              {'--pdf-engine=xelatex'},
              {'--citeproc'},
              {'--variable', 'geometry:margin=1in'},
              {'--variable', 'fontsize=12pt'},
              {'--variable', 'documentclass=article'},
              {'--number-sections'},
              {'--table-of-contents'},
              {'--bibliography=references.bib'},
              {'--csl=ieee.csl'},
              {'--highlight-style=tango'},
              {'--standalone'}
            }
          },
          -- Simple Report Style
          {
            name = "report",
            args = {
              {'-f', 'markdown'},
              {'-t', 'pdf'},
              {'--pdf-engine=pdflatex'},
              {'--variable', 'geometry:margin=1.2in'},
              {'--variable', 'fontsize=11pt'},
              {'--variable', 'documentclass=report'},
              {'--number-sections'},
              {'--table-of-contents'},
              {'--highlight-style=github'},
              {'--standalone'}
            }
          },
          -- Presentation Style
          {
            name = "slides",
            args = {
              {'-f', 'markdown'},
              {'-t', 'beamer'},
              {'--pdf-engine=pdflatex'},
              {'--variable', 'theme:Madrid'},
              {'--variable', 'colortheme:default'},
              {'--highlight-style=tango'},
              {'--standalone'}
            }
          },
          -- Simple Clean Style (your most likely choice)
          {
            name = "clean",
            args = {
              {'-f', 'markdown'},
              {'-t', 'pdf'},
              {'--pdf-engine=xelatex'},
              {'--variable', 'geometry:margin=1in'},
              {'--variable', 'fontsize=11pt'},
              {'--variable', 'mainfont=Arial'},
              {'--variable', 'documentclass=article'},
              {'--highlight-style=github'},
              {'--standalone'}
            }
          }
        }
      })
    end,
  },

  -- Alternative: vim-pandoc for extensive Pandoc integration
  {
    'vim-pandoc/vim-pandoc',
    ft = "markdown",
    dependencies = {
      'vim-pandoc/vim-pandoc-syntax'
    },
    config = function()
      vim.g["pandoc#filetypes#handled"] = {"pandoc", "markdown"}
      vim.g["pandoc#filetypes#pandoc_markdown"] = 0
      vim.g["pandoc#modules#disabled"] = {"folding", "spell"}
      vim.g["pandoc#formatting#mode"] = "h"
      vim.g["pandoc#formatting#textwidth"] = 79
    end,
  },
}