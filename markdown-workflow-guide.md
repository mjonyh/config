# Complete Markdown + PDF Workflow for Neovim

## 🚀 Your Enhanced Markdown Setup

I've significantly enhanced your markdown workflow with professional-grade plugins optimized for PDF generation and beautiful editing experience.

## 📦 Plugin Overview

### **What You Already Had (Enhanced):**
1. **render-markdown.nvim** ✨ *Enhanced* - Beautiful in-editor rendering with GitHub callouts
2. **md-pdf.nvim** ✨ *Enhanced* - Quick PDF generation with better styling  
3. **markmap.nvim** ✅ *Kept* - Mind maps from markdown

### **New Additions for Professional Workflow:**

#### **1. markdown-preview.nvim** - Live Browser Preview
- **Purpose:** Real-time preview in browser while editing
- **Key:** `<leader>mp` - Toggle live preview
- **Features:** Auto-refresh, math support, diagram support

#### **2. aspeddro/pandoc.nvim** - Professional PDF Generation  
- **Purpose:** Multiple PDF styles with Pandoc integration
- **Keys:** 
  - `<leader>pdf` - Compile to PDF and open
  - `<leader>pdc` - Compile only
  - `<leader>pdo` - Open last output
- **Styles:** Academic, Report, Clean, Slides

#### **3. vim-table-mode** - Easy Table Creation
- **Purpose:** Excel-like table editing in markdown
- **Key:** `<leader>tm` - Toggle table mode
- **Features:** Auto-formatting, easy column manipulation

#### **4. mkdnflow.nvim** - Advanced Markdown Navigation
- **Purpose:** Link navigation, note-taking workflow
- **Features:** 
  - `<CR>` - Follow/create links
  - `<Tab>/<S-Tab>` - Navigate between links
  - `<C-Space>` - Toggle todo items

#### **5. vim-pandoc** - Extensive Pandoc Integration
- **Purpose:** Full pandoc ecosystem support
- **Features:** Citations, bibliographies, academic writing

## ⌨️ Complete Keybinding Reference

### **PDF Generation:**
```vim
<leader>pdf      " Pandoc: Compile to PDF and open (recommended)
<leader>pdc      " Pandoc: Compile only  
<leader>pdo      " Pandoc: Open last output
<leader>mdpdf    " md-pdf: Quick PDF conversion
```

### **Live Preview:**
```vim
<leader>mp       " Toggle live browser preview
<leader>mr       " Toggle in-editor rendering
```

### **Table Editing:**
```vim
<leader>tm       " Toggle table mode
|| (in table mode) " Auto-create table structure
```

### **Navigation & Links:**
```vim
<CR>             " Follow/create markdown links
<Tab>            " Next link
<S-Tab>          " Previous link
]]               " Next heading
[[               " Previous heading
<BS>             " Go back in link history
<leader>p        " Create link from clipboard
```

### **Task Management:**
```vim
<C-Space>        " Toggle todo checkbox
<leader>nn       " Update list numbering
```

### **Mind Maps:**
```vim
:MarkmapOpen     " Open mind map
:MarkmapSave     " Save mind map
:MarkmapWatch    " Auto-update mind map
```

## 🎯 Workflow Examples

### **1. Quick Document → PDF:**
```markdown
# My Document

Some content here...

## Section 1
More content...
```
**Steps:**
1. Write your markdown
2. Press `<leader>pdf` 
3. PDF opens automatically with professional styling

### **2. Academic Paper Workflow:**
```markdown
---
title: "My Research Paper"
author: "Your Name"
date: "2024"
bibliography: references.bib
---

# Introduction
Research shows [@author2024]...

## Methodology
...
```
**Steps:**
1. Write with citations
2. `:PandocCompile academic` for academic style
3. Get properly formatted academic PDF

### **3. Live Preview Workflow:**
1. Open markdown file
2. Press `<leader>mp` for live preview
3. Edit file - see changes in real-time in browser
4. When satisfied, press `<leader>pdf` for final PDF

### **4. Table Creation:**
1. Press `<leader>tm` to enter table mode
2. Type: `| Header 1 | Header 2 |`
3. Press `||` to auto-create table structure
4. Fill in your data - tables auto-format

### **5. Note-Taking with Links:**
```markdown
# Main Topic

See [[related-topic]] for more details.
Todo: [x] Complete research
Todo: [ ] Write conclusion
```
- Press `<CR>` on `[[related-topic]]` to create/navigate
- Press `<C-Space>` on todo items to toggle completion

## 📊 PDF Style Options

### **Clean Style** (Default - Best for most documents):
```bash
# Triggered by: <leader>pdf
Features:
- Clean Arial font
- 1-inch margins  
- GitHub syntax highlighting
- Professional appearance
```

### **Academic Style:**
```bash
# Triggered by: :PandocCompile academic
Features:
- Citation support
- IEEE reference style
- Table of contents
- Numbered sections
- Bibliography integration
```

### **Report Style:**
```bash
# Triggered by: :PandocCompile report  
Features:
- Report document class
- Larger margins
- Professional formatting
- Chapter-style sections
```

### **Slides Style:**
```bash
# Triggered by: :PandocCompile slides
Features:
- Beamer presentation format
- Professional slide themes
- Perfect for presentations
```

## 🛠 System Requirements & Setup

### **Required Tools:**
```bash
# Install Pandoc (for PDF generation)
brew install pandoc

# Install LaTeX (for PDF rendering) - Choose one:
brew install --cask mactex          # Full LaTeX (4GB+)
brew install basictex              # Minimal LaTeX (100MB)

# For presentations/slides:
brew install --cask skim           # PDF viewer with auto-refresh
```

### **Optional Enhancements:**
```bash
# For citations and bibliography:
brew install pandoc-citeproc

# For better fonts in PDF:
brew tap homebrew/cask-fonts
brew install --cask font-fira-code
```

## 🎨 Customization Options

### **Custom PDF Styles:**
Edit `nvim/lua/plugins/pandoc-pdf.lua` to add your own styles:

```lua
{
  name = "mystyle",
  args = {
    {'-f', 'markdown'},
    {'-t', 'pdf'},
    {'--variable', 'geometry:margin=0.8in'},
    {'--variable', 'fontsize=10pt'},
    {'--variable', 'mainfont=Times New Roman'},
    -- Add your custom options
  }
}
```

### **Custom Markdown Rendering:**
Edit `nvim/lua/plugins/render-markdown.lua` to customize appearance:

```lua
headings = {'🔵 ', '🟠 ', '🟡 ', '🟢 ', '🟣 ', '🔴 '},  -- Custom heading icons
bullet = {
  icons = { '▶', '▷', '▸', '▹' },  -- Custom bullet styles
},
```

## 🚀 Pro Tips

### **1. Efficient PDF Generation:**
- Use `<leader>pdf` for 90% of your documents
- Use academic style only for papers with citations
- Keep a template file for common document types

### **2. Live Preview Best Practices:**
- Start preview early in writing process
- Use split windows: markdown on left, preview on right
- Preview auto-refreshes on save

### **3. Table Creation Tips:**
- Enter table mode before creating tables
- Use `||` to quickly expand table structure  
- Tables auto-format on cursor movement

### **4. Link Management:**
- Use `[[link-name]]` for internal links
- Press `<CR>` to create files that don't exist
- Use `<leader>p` to create links from clipboard URLs

### **5. Task Management:**
- Use `- [ ]` for unchecked tasks
- Use `- [x]` for completed tasks  
- Press `<C-Space>` to toggle quickly

## 📋 Markdown Enhancement Checklist

### **Writing Experience:** ✅
- [x] Beautiful in-editor rendering with icons
- [x] Live browser preview  
- [x] Easy table creation and formatting
- [x] Link navigation and management
- [x] Todo/task management
- [x] GitHub-style callouts and alerts

### **PDF Generation:** ✅  
- [x] Multiple professional PDF styles
- [x] Academic paper support with citations
- [x] Presentation/slides generation
- [x] Clean, customizable formatting
- [x] One-keystroke PDF generation

### **Advanced Features:** ✅
- [x] Mind map generation
- [x] Table of contents generation  
- [x] Syntax highlighting in PDFs
- [x] Math equation support
- [x] Diagram and flowchart support

## 🎉 Result

You now have a **professional-grade markdown workflow** that rivals dedicated markdown editors while staying within Neovim. This setup is perfect for:

- ✅ **Technical documentation** with code blocks
- ✅ **Academic papers** with citations  
- ✅ **Reports and proposals** with professional styling
- ✅ **Note-taking** with linking and organization
- ✅ **Presentations** converted to slides
- ✅ **Any document** that needs to become a PDF

**Your markdown → PDF workflow is now effortless and professional!** 🚀