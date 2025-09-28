-- Simple Markdown to PDF - Always Works!
return {
  -- Custom simple PDF generation function
  {
    "nvim-lua/plenary.nvim", -- Required for async
    config = function()
      -- Simple markdown to PDF function using system pandoc
      local function markdown_to_pdf()
        local current_file = vim.fn.expand("%:p")
        local file_extension = vim.fn.expand("%:e")
        
        -- Check if it's a markdown file
        if file_extension ~= "md" and file_extension ~= "markdown" then
          vim.notify("❌ Not a markdown file!", vim.log.levels.ERROR)
          return
        end
        
        -- Generate output filename
        local output_file = vim.fn.expand("%:p:r") .. ".pdf"
        
        -- Save the file first
        vim.cmd("write")
        
        -- Show progress
        vim.notify("🔄 Generating PDF...", vim.log.levels.INFO)
        
        -- Pandoc command
        local cmd = {
          "pandoc",
          current_file,
          "-o", output_file,
          "--pdf-engine=xelatex",
          "--variable=geometry:margin=1in", 
          "--variable=fontsize=11pt",
          "--highlight-style", "github",
          "--standalone"
        }
        
        -- Run pandoc
        local result = vim.fn.system(cmd)
        local exit_code = vim.v.shell_error
        
        if exit_code == 0 then
          vim.notify("✅ PDF generated: " .. vim.fn.fnamemodify(output_file, ":t"), vim.log.levels.INFO)
          -- Open the PDF
          if vim.fn.has("mac") == 1 then
            vim.fn.system("open '" .. output_file .. "'")
          elseif vim.fn.has("unix") == 1 then
            vim.fn.system("xdg-open '" .. output_file .. "'")
          end
        else
          vim.notify("❌ PDF generation failed: " .. result, vim.log.levels.ERROR)
        end
      end
      
      -- Simple HTML preview function
      local function markdown_to_html_preview()
        local current_file = vim.fn.expand("%:p")
        local file_extension = vim.fn.expand("%:e")
        
        if file_extension ~= "md" and file_extension ~= "markdown" then
          vim.notify("❌ Not a markdown file!", vim.log.levels.ERROR)
          return
        end
        
        local output_file = "/tmp/" .. vim.fn.expand("%:t:r") .. "_preview.html"
        vim.cmd("write")
        
        local cmd = {
          "pandoc",
          current_file,
          "-o", output_file,
          "--standalone",
          "--css=https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.2.0/github-markdown-light.min.css",
          "--highlight-style", "github"
        }
        
        local result = vim.fn.system(cmd)
        if vim.v.shell_error == 0 then
          if vim.fn.has("mac") == 1 then
            vim.fn.system("open '" .. output_file .. "'")
          end
          vim.notify("✅ HTML preview opened", vim.log.levels.INFO)
        else
          vim.notify("❌ HTML generation failed: " .. result, vim.log.levels.ERROR)
        end
      end
      
      -- Create user commands
      vim.api.nvim_create_user_command("MarkdownToPDF", markdown_to_pdf, {
        desc = "Convert current markdown file to PDF"
      })
      
      vim.api.nvim_create_user_command("MarkdownPreviewHTML", markdown_to_html_preview, {
        desc = "Preview current markdown file as HTML"
      })
      
      -- Keymappings for markdown files only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          local opts = { buffer = true, silent = true }
          
          vim.keymap.set("n", "<leader>pdf", markdown_to_pdf, 
            vim.tbl_extend("force", opts, { desc = "Convert to PDF" }))
          
          vim.keymap.set("n", "<leader>html", markdown_to_html_preview,
            vim.tbl_extend("force", opts, { desc = "Preview as HTML" }))
          
          vim.keymap.set("n", "<leader>mpdf", markdown_to_pdf,
            vim.tbl_extend("force", opts, { desc = "Markdown to PDF (simple)" }))
        end,
      })
    end,
  },
}