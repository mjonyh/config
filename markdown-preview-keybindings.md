# Markdown Preview Keybindings Reference

## 🔍 **Current Preview Keybindings:**

### **Live Browser Preview:**
```vim
<leader>mp       " Toggle markdown live preview in browser
                 " Opens/closes real-time preview with auto-refresh
                 " Plugin: markdown-preview.nvim
```

### **In-Editor Rendering:**
```vim
<leader>mr       " Toggle markdown rendering inside Neovim
                 " Shows/hides beautiful markdown formatting in editor
                 " Plugin: render-markdown.nvim
```

### **PDF Preview:**
```vim
<leader>pdf      " Compile to PDF and open (main PDF workflow)
                 " Creates professional PDF and opens it
                 " Plugin: pandoc.nvim

<leader>mdpdf    " Quick markdown to PDF conversion
                 " Alternative PDF generation method  
                 " Plugin: md-pdf.nvim

<leader>mdp      " Markdown PDF preview (alternative)
                 " Plugin: nvim-markdown-preview
```

### **Additional Pandoc Commands:**
```vim
<leader>pdc      " Pandoc compile only (no auto-open)
<leader>pdo      " Open last pandoc output
```

## 🎯 **Which Preview Should You Use?**

### **For Writing/Editing:** 
- **`<leader>mp`** - Live browser preview
  - ✅ Best for real-time editing
  - ✅ Shows exactly how it will look
  - ✅ Auto-refreshes on save
  - ✅ Math equations, diagrams, tables

### **For In-Editor Beauty:**
- **`<leader>mr`** - In-editor rendering
  - ✅ Beautiful icons and formatting
  - ✅ No external windows
  - ✅ GitHub-style callouts
  - ✅ Syntax highlighting

### **For Final Output:**
- **`<leader>pdf`** - Professional PDF
  - ✅ Your main workflow for PDF output
  - ✅ Multiple professional styles
  - ✅ Perfect formatting

## 🚀 **Recommended Workflow:**

```bash
# 1. Start writing with in-editor beauty
nvim my-document.md
<leader>mr        # Enable beautiful in-editor rendering

# 2. For complex editing, use live preview
<leader>mp        # Open live browser preview

# 3. When ready for final output
<leader>pdf       # Generate professional PDF
```

## 📱 **Preview Commands (Vim Commands):**

### **Browser Preview Commands:**
```vim
:MarkdownPreview         " Start live preview
:MarkdownPreviewToggle   " Toggle live preview  
:MarkdownPreviewStop     " Stop live preview
```

### **Render Markdown Commands:**
```vim
:RenderMarkdown toggle   " Toggle in-editor rendering
:RenderMarkdown enable   " Enable rendering
:RenderMarkdown disable  " Disable rendering
```

### **Pandoc Commands:**
```vim
:PandocCompile          " Compile with pandoc
:PandocCompileAndOpen   " Compile and open result
:PandocOpen             " Open last output
:PandocClean            " Clean output files
```

## 💡 **Pro Tips:**

### **Split Screen Workflow:**
```vim
# Open markdown file
nvim document.md

# Split vertically and start preview
:vsplit
<leader>mp              # Live preview in browser
# Now you have: markdown on left, live preview in browser
```

### **Quick Toggle Workflow:**
```vim
<leader>mr              # Quick toggle for in-editor rendering
<leader>mp              # Quick toggle for browser preview
```

### **Preview + Edit Loop:**
1. **`<leader>mr`** - See beautiful rendering while editing
2. **`<leader>mp`** - Check complex formatting in browser  
3. **`<leader>pdf`** - Generate final PDF when satisfied

## 🎨 **What Each Preview Shows:**

### **`<leader>mr` (In-Editor Rendering):**
- ✨ Beautiful heading icons (󰲡, 󰲣, 󰲥)
- 🎯 Styled bullet points (●, ○, ◆)
- ✅ Checkboxes with icons (󰄱, 󰱒)
- 📋 Formatted tables
- 🎨 GitHub callouts ([!NOTE], [!WARNING])
- 🔗 Link highlighting

### **`<leader>mp` (Browser Preview):**
- 🌐 Full HTML rendering
- 📊 Math equations (KaTeX)
- 📈 Diagrams and flowcharts  
- 🎨 CSS styling
- 📱 Responsive layout
- 🔄 Auto-refresh on save

### **`<leader>pdf` (PDF Output):**
- 📄 Professional document formatting
- 🎯 Clean typography
- 📊 Proper page breaks
- 🔢 Page numbers
- 📋 Table of contents (if enabled)
- 🎨 Syntax-highlighted code blocks

## ⌨️ **Additional Useful Keybindings:**

### **Table Editing:**
```vim
<leader>tm       " Toggle table mode for easy table creation
```

### **Navigation:**
```vim
<CR>             " Follow markdown links
<Tab>            " Next link  
<S-Tab>          " Previous link
]]               " Next heading
[[               " Previous heading
```

### **Task Management:**
```vim
<C-Space>        " Toggle todo checkboxes
```

## 🎉 **Summary:**

**You have 3 types of preview:**

1. **`<leader>mr`** - Beautiful in-editor rendering ✨
2. **`<leader>mp`** - Live browser preview 🌐  
3. **`<leader>pdf`** - Professional PDF output 📄

**Most efficient workflow:**
- Write with `<leader>mr` for beauty
- Preview with `<leader>mp` for accuracy
- Output with `<leader>pdf` for final result

All your preview needs are covered! 🚀