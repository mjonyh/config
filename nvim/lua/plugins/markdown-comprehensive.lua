-- Comprehensive Markdown Plugin with PDF Generation
return {
  -- Enhanced markdown rendering and PDF generation
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      -- Markdown preview settings
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_theme = 'dark'
    end,
  },
  -- PDF Generation with pandoc
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Available pandoc highlight styles for reference
      local highlight_styles = {
        "pygments", "tango", "espresso", "zenburn", 
        "kate", "monochrome", "breezedark", "haddock"
      }

      -- PDF generation function with multiple highlighting options
      local function markdown_to_pdf(highlight_style)
        highlight_style = highlight_style or "breezedark"  -- Default dark theme
        
        local current_file = vim.fn.expand("%:p")
        local file_extension = vim.fn.expand("%:e")
        
        if file_extension ~= "md" and file_extension ~= "markdown" then
          vim.notify("❌ Not a markdown file!", vim.log.levels.ERROR)
          return
        end
        
        local output_file = vim.fn.expand("%:p:r") .. ".pdf"
        vim.cmd("write")
        vim.notify("🔄 Generating PDF with " .. highlight_style .. " theme...", vim.log.levels.INFO)
        
        -- Modern pandoc command with proper syntax highlighting
        local cmd = {
          "pandoc",
          current_file,
          "-o", output_file,
          "--pdf-engine=xelatex",
          "--highlight-style=" .. highlight_style,
          "--variable=papersize:a4paper",
          "--variable=geometry:margin=1in", 
          "--variable=fontsize=11pt",
          "--variable=linestretch=1.15",
          "--variable=colorlinks=true",
          "--variable=linkcolor=blue",
          "--variable=urlcolor=blue",
          "--variable=toccolor=black",
          "--table-of-contents",
          "--number-sections",
          "--standalone"
        }
        
        local result = vim.fn.system(cmd)
        local exit_code = vim.v.shell_error
        
        if exit_code == 0 then
          vim.notify("✅ PDF generated: " .. vim.fn.fnamemodify(output_file, ":t"), vim.log.levels.INFO)
          if vim.fn.has("mac") == 1 then
            vim.fn.system("open '" .. output_file .. "'")
          end
        else
          -- Fallback to simpler command if advanced features fail
          vim.notify("⚠️ Advanced PDF failed, trying simple mode...", vim.log.levels.WARN)
          
          local simple_cmd = {
            "pandoc",
            current_file,
            "-o", output_file,
            "--pdf-engine=xelatex",
            "--highlight-style=" .. highlight_style,
            "--variable=geometry:a4paper,margin=1in",
            "--variable=fontsize=11pt",
            "--standalone"
          }
          
          local simple_result = vim.fn.system(simple_cmd)
          if vim.v.shell_error == 0 then
            vim.notify("✅ Simple PDF generated successfully!", vim.log.levels.INFO)
            if vim.fn.has("mac") == 1 then
              vim.fn.system("open '" .. output_file .. "'")
            end
          else
            vim.notify("❌ PDF generation failed: " .. simple_result, vim.log.levels.ERROR)
          end
        end
      end

      -- Create user commands for different themes
      vim.api.nvim_create_user_command("MarkdownToPDFDark", function()
        markdown_to_pdf("breezedark")
      end, { desc = "Convert markdown to PDF with dark theme" })

      vim.api.nvim_create_user_command("MarkdownToPDFLight", function()
        markdown_to_pdf("kate")
      end, { desc = "Convert markdown to PDF with light theme" })

      vim.api.nvim_create_user_command("MarkdownToPDF", function(opts)
        local style = opts.args ~= "" and opts.args or "breezedark"
        markdown_to_pdf(style)
      end, { 
        desc = "Convert markdown to PDF with specified highlight style",
        nargs = "?",
        complete = function()
          return highlight_styles
        end
      })
      
      -- Keybindings for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local map = vim.keymap.set
          local opts = { buffer = true, silent = true }
          
          -- PDF generation with different themes
          map("n", "<leader>pdf", function() markdown_to_pdf("breezedark") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Dark Theme)" }))
          map("n", "<leader>pdfl", function() markdown_to_pdf("kate") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Light Theme)" }))
          map("n", "<leader>pdfp", function() markdown_to_pdf("pygments") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Pygments)" }))
          map("n", "<leader>pdfz", function() markdown_to_pdf("zenburn") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Zenburn)" }))
          map("n", "<leader>pdfe", function() markdown_to_pdf("espresso") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Espresso)" }))
          map("n", "<leader>pdft", function() markdown_to_pdf("tango") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Tango)" }))
          map("n", "<leader>pdfh", function() markdown_to_pdf("haddock") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Haddock)" }))
          map("n", "<leader>pdfm", function() markdown_to_pdf("monochrome") end, 
            vim.tbl_extend("force", opts, { desc = "PDF (Monochrome)" }))

          -- Preview toggle
          map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", 
            vim.tbl_extend("force", opts, { desc = "Toggle Markdown Preview" }))
        end,
      })
    end,
  },
}