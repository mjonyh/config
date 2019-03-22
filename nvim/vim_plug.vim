""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin manager vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')


" 1. NERDtree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" 2. Theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'joshdick/onedark.vim'
Plug 'ap/vim-css-color'
Plug 'tmhedberg/simpylfold'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-vividchalk'
Plug 'tpope/vim-markdown'
Plug 'vim-scripts/SyntaxRange'

" 3. Snippets : Let the vim write for you
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'

" 4. Latex plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'xuhdev/vim-latex-live-preview'
Plug 'gerw/vim-latex-suite'

" 5. Auto complete words and others
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'valloric/youcompleteme'
" Plug 'shougo/deoplete.nvim'


" 6. Git's plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" 7. Parentheses completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'chun-yang/auto-pairs'
Plug 'tpope/vim-surround'

" 8. File management / search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ctrlpvim/ctrlp.vim'

" 9. Using Comment's for different file extensions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-commentary'

" 10. Word search plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'

" 11. Format documents
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'chiel92/vim-autoformat'
" ToDo: Write description and usages

" 12. Title Case (First letter capitalization)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'christoomey/vim-titlecase'
" <leader> gT: will make the title case

" 13. Highlight Current line
" "Plug 'highlight_current_line.vim'
" This plugin will highlight currentline

" 14. vim tmux plugin
" Plug 'tmux-plugins/vim-tmux'

" 15. syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/syntastic'
Plug 'w0rp/ale'
Plug 'dbeniamine/cheat.sh-vim'
" K get answer on the word under the cursor or the selection on a pager (this feature requires vim >= 7.4.1833, you can check if have the right version with : :echo has("patch-7.4.1833"))
" <leader>KK same as K but works on lines or visual selection (not working on neovim, because they killed interactive commands with :!)
" <leader>KB get the answer on a special buffer
" <leader>KR Replace your question by the answer
" <leader>KP Past the answer below your question
" <leader>KC Replay last query, toggling comments
" <leader>KE Send first error to cht.sh
" <leader>C Toggle showing comments by default see configuration
" <leader>KL Replay last query


" 16. supertab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'ervandew/supertab'

" 17. multiple cursor
" Plug 'terryma/vim-multiple-cursors'

" 18. Unix command
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-eunuch'

"19. Multicursor
Plug 'terryma/vim-multiple-cursors'
"
"
" 20. vim presentation
Plug 'sotte/presenting.vim'
"


" Initialize plugin system
call plug#end()
