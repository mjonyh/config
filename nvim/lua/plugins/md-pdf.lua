return {
    'arminveres/md-pdf.nvim',
    branch = 'main',
    ft = "markdown",
    lazy = true,
    keys = {
        {
            "<leader>mdpdf",
            function() require("md-pdf").convert_md_to_pdf() end,
            desc = "Convert Markdown to PDF",
        },
    },
    config = function()
      require("md-pdf").setup({
        -- Set margins (in inches)
        margins = "1in",
        -- Set toc (table of contents)
        toc = true,
        -- pandoc_user_args can be used as an escape hatch when you want to set
        -- a pandoc argument that is not represented in the setup opts, it gets
        -- passed to the end of the pandoc command
        pandoc_user_args = {
          "--pdf-engine=xelatex",
          "--variable=geometry:letterpaper",
          "--variable=fontsize:11pt",
          "--highlight-style=github"
        }
      })
    end,
}
