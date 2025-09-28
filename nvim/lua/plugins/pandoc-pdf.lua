-- Professional PDF Generation with Pandoc - FIXED
return {
  {
    "nvim-lua/plenary.nvim",
    config = function()
      -- Enhanced markdown to PDF with dark theme styling
      local function markdown_to_pdf_dark()
        local current_file = vim.fn.expand("%:p")
        local file_extension = vim.fn.expand("%:e")
        
        if file_extension ~= "md" and file_extension ~= "markdown" then
          vim.notify("❌ Not a markdown file!", vim.log.levels.ERROR)
          return
        end
        
        local output_file = vim.fn.expand("%:p:r") .. ".pdf"
        vim.cmd("write")
        vim.notify("🔄 Generating PDF with dark theme...", vim.log.levels.INFO)
        
        -- Fixed pandoc command with modern syntax
        local cmd = {
          "pandoc",
          current_file,
          "-o", output_file,
          "--pdf-engine=xelatex",
          "--syntax-highlighting=breezedark",  -- Modern syntax
          "--variable=papersize:a4",
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
            "--syntax-highlighting=pygments",
            "--variable=geometry:a4,margin=1in",
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
      
      -- Create user commands
      vim.api.nvim_create_user_command("MarkdownToPDFDark", markdown_to_pdf_dark, {
        desc = "Convert markdown to PDF with dark theme styling"
      })
      
      -- Keybinding for markdown files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("n", "<leader>pdfc", markdown_to_pdf_dark, 
            { buffer = true, silent = true, desc = "PDF with dark theme" })
        end,
      })
    end,
  },
}