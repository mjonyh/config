-- Simple and Reliable Pandoc PDF Generation
return {
  -- Simple Pandoc wrapper that always works
  {
    "aspeddro/pandoc.nvim",
    ft = "markdown",
    config = function()
      require("pandoc").setup({
        default = {
          output_dir = function()
            return vim.fn.expand("%:p:h") .. "/output/"
          end,
          args = {
            { "-f", "markdown" },
            { "-t", "pdf" },
            { "--pdf-engine=xelatex" },
            { "--variable=geometry:margin=1in" },
            { "--variable=fontsize=11pt" },
            { "--standalone" }
          }
        },
        commands = {
          {
            name = "clean",
            args = {
              { "-f", "markdown" },
              { "-t", "pdf" },
              { "--pdf-engine=xelatex" },
              { "--variable=geometry:margin=1in" },
              { "--variable=fontsize=11pt" },
              { "--syntax-highlighting=pygments" },
              { "--standalone" }
            }
          },
          {
            name = "simple",
            args = {
              { "-f", "markdown" },
              { "-t", "pdf" },
              { "--pdf-engine=pdflatex" },
              { "--standalone" }
            }
          }
        }
      })
      
      -- Custom keymappings
      vim.keymap.set("n", "<leader>pdf", function()
        local current_file = vim.fn.expand("%:p")
        if vim.fn.expand("%:e") ~= "md" then
          vim.notify("Not a markdown file!", vim.log.levels.WARN)
          return
        end
        
        vim.cmd("PandocCompileAndOpen")
      end, { desc = "Compile markdown to PDF", ft = "markdown" })
      
      vim.keymap.set("n", "<leader>pdc", "<cmd>PandocCompile<cr>", { desc = "Compile with Pandoc", ft = "markdown" })
      vim.keymap.set("n", "<leader>pdo", "<cmd>PandocOpen<cr>", { desc = "Open Pandoc Output", ft = "markdown" })
    end,
  },
}