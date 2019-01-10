" pathogen
execute pathogen#infect()
syntax on
filetype plugin on
filetype plugin indent on

set encoding=utf-8

" for nerdtree short cut
map <C-n> :NERDTreeToggle<CR>


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

" default spell check
set spell!

" Display line number
set relativenumber  	" for relative number"
set number 		" for current line number"

" Number of text in a line
set tw=79

" Color scheme
colorscheme molokai
autocmd Filetype python colorscheme dracula

" Automatic savings
let g:auto_save = 1  " enable AutoSave on Vim startup

" UltiSnips trigger since contradict with youcomplete me
let g:UltiSnipsExpandTrigger="<C-w>"

let g:ultisnips_python_style="doxygen"
"
" autopairs
let g:AutoPairsFlyMode = 1

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string

" mouse on
set mouse=a

