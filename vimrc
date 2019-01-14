set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

"""""""""""""""""""""""""""""""""""""""
" I am interested in the bellows plugin
"""""""""""""""""""""""""""""""""""""""
" 1. Sidebar
Plugin 'scrooloose/nerdtree'
" Ctrl + n: NERDTreeToggle will be used
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" For icon and highlight in NERDTree
Plugin 'ryanoasis/vim-devicons'

" 2. Theme
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'
" Customized icons are used

" 3. Snippets : Let the vim write for you
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
" Ctrl + w: complete the snippets

" 4. Latex plugin
Plugin 'xuhdev/vim-latex-live-preview'
" LLStartPreview will be used to view
Plugin 'gerw/vim-latex-suite'
" Along with snippets this package provide a lot of useful snippets

" 5. Auto complete words and others
Plugin 'valloric/youcompleteme'

" 6. Git's plugin
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
" ToDo: Write the descriptions and keymaps 

" 7. Parentheses completion 
Plugin 'chun-yang/auto-pairs'

" 8. File management / search
Plugin 'ctrlpvim/ctrlp.vim'
" todo: write description and use
" Ctrl + p: will search for file in both normal and insert mode

" 9. Using Comment's for different file extensions
Plugin 'tpope/vim-commentary'
" gcgc: comments in / out in selected lines

" 10. Word search plugin
Plugin 'easymotion/vim-easymotion'
" ToDo: Write description and usage 
" <leader><leader>s for search word
" type one word then chose one word
"
" 11. Format documents
Plugin 'chiel92/vim-autoformat'
" ToDo: Write description and usages

" 12. Title Case (First letter capitalization)
Plugin 'christoomey/vim-titlecase'
" ToDo: Write description and usages

" 13. Highlight Current line
Plugin 'highlight_current_line.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" vim +PluginInstall +qall 	- Install plugins from command line
"
""""""""""""""""""""""""""""""""""""""
" From earlier vimrc 
""""""""""""""""""""""""""""""""""""""
" Default Settings
""""""""""""""""""""""""""""""""""""""
syntax on
set encoding=utf-8

" default spell check
set spell!
imap <C-f> <C-g>u<Esc>[s1z=`]a<C-g>u
nmap <C-f> [s1z=<C-o>

" Display line number
set relativenumber  	" for relative number"
set number 		" for current line number"

" Number of text in a line
" set tw=79

" Automatic savings
let g:auto_save = 1  " enable AutoSave on Vim startup
" mouse on
set mouse=a

" Tabbing windows
nnoremap <C-k> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
imap <C-k> <Esc>:tabprevious<CR>
imap <C-l> <Esc>:tabnext<CR>
imap <C-e> <Esc> :tabe  
nmap <C-e> :tabe 

let mapleader=","

""""""""""""""""""""""""""""""""""""""
" 1. nerdtree short cut
imap <C-n> <Esc>:NERDTreeToggle<CR>
nmap <C-n> :NERDTreeToggle<CR>
" NERDTree will open if no file is selected
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTree close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Sign
" let g:NERDTreeDirArrowExpandable = '\uf35a'
" let g:NERDTreeDirArrowCollapsible = '\uf358'


""""""""""""""""""""""""""""""""""""""
" 2. Theme customization
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" my symbols
let g:airline_left_sep="\uE0B4"
let g:airline_left_alt_sep="\uE0B5"
let g:airline_right_sep="\uE0B6"
let g:airline_right_alt_sep="\uE0B7"

" Color scheme
colorscheme molokai
"autocmd Filetype python colorscheme dracula


""""""""""""""""""""""""""""""""""""""
" 3. Snippets
" UltiSnips trigger since contradict with youcomplete me
let g:UltiSnipsExpandTrigger="<C-w>"
let g:ultisnips_python_style="doxygen"

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4


""""""""""""""""""""""""""""""""""""""
" 4. latex plugins
" Configuration for the llstartpreview  
autocmd Filetype tex setl updatetime=1
autocmd Filetype tex set tw=79
let g:livepreview_previewer = 'open -a Preview'

" for vim-latex-suite
let g:tex_flavor='latex'
let g:Tex_EnvLabelprefix_equation = "eq:"
let g:Tex_EnvLabelprefix_figure = "fig:"
let g:Tex_EnvLabelprefix_table = "table:"
let g:Tex_Env_figure="\\begin{figure}[<+htpb+>]\<cr>\\centering\<cr>\\includegraphics[width=0.75\\textwidth]{<+file+>}\<cr>\\caption{<+caption text+>}\<cr>\\label{fig:<+label+>}\<cr>\\end{figure}\<cr><++>"


""""""""""""""""""""""""""""""""""""""
" 5. YouCompleteMe
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string


""""""""""""""""""""""""""""""""""""""
" 6. Git Plugins
" gitgutter settings
" let g:gitgutter_highlight_lines = 1
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '~~'
let g:gitgutter_sign_removed = '--'
let g:gitgutter_sign_removed_first_line = '^^'
let g:gitgutter_sign_modified_removed = 'ww'


""""""""""""""""""""""""""""""""""""""
" 7. Auto Parentheses
let g:AutoPairsFlyMode = 1


""""""""""""""""""""""""""""""""""""""
" 8. File management / search
" Ctrl+p will search for files in both normal and insert mode
imap <C-p> <Esc> :CtrlP<CR>


""""""""""""""""""""""""""""""""""""""
" 9. Using Comment's for different file extensions



""""""""""""""""""""""""""""""""""""""
" 10. Word search plugin


"
""""""""""""""""""""""""""""""""""""""
" 11. Format documents



""""""""""""""""""""""""""""""""""""""
" 12. Title Case (First letter capitalization)






