call plug#begin('~/.config/nvim/bundle')
" List of all plugins to use
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " Autocompletion
Plug 'scrooloose/nerdtree' " File overview
Plug 'scrooloose/syntastic' " Syntax highlighting
Plug 'tpope/vim-surround' " Surround words with parenthesis, etc...
Plug 'bling/vim-airline' " Infobar
Plug 'vim-airline/vim-airline-themes'
"Plug 'altercation/vim-colors-solarized' " Solarized palette
Plug 'scrooloose/nerdcommenter' " Comment out code
Plug 'jiangmiao/auto-pairs' " Adds parenthesis pair instead of just ( when typing
Plug 'zchee/deoplete-go', {'do': 'make'} " Auto-completion for golang
Plug 'zchee/deoplete-jedi' " Auto-completion for python
Plug 'sheerun/vim-polyglot' " Language support for some languages
Plug 'majutsushi/tagbar' " overview of variables, etc..
Plug 'SirVer/ultisnips' " Snippets for autocompletion, ...
Plug 'honza/vim-snippets' " Actual snippets for ultisnips
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " live preview for LaTeX
Plug 'zchee/deoplete-clang' " Autocompletion for C/C++
call plug#end()

" Initialization

" Auto start NERD tree when opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Basic variables
filetype plugin indent on
syntax on
let mapleader = "\<space>"
set number
set incsearch
set nohlsearch
set smartcase
set tabstop=4
set softtabstop=0
set expandtab
set shiftwidth=4
set noswapfile
set nowrap
let g:deoplete#sources#go#gocode_binary = $HOME.'/go/bin/gocode'

" Make split windows look more clean
set fillchars+=vert:\ 
hi VertSplit ctermfg=LightGray

"#######Preferences########
" NERDTree
let NERDTreeQuitOnOpen = 1
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1 " Delete Buffer when file deleted
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1 " Show hidden files
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp'] " Ignore useless files
        
" Vim
" noremap Y 0y$
set hidden
set history=100
"autocmd BufWritePre * :%s/\s\+$//e " Delete whitespaces on saving
" Cancel searches with Escape
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
" Reopen previously opened file
nnoremap <Leader><Leader> :e#<CR>
" Highlight trailing whitespaces
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=grey guibg=grey
" get rid of ~
"highlight EndOfBuffer ctermfg=bg ctermbg=NONE

" Autocompletion colors
highlight Pmenu ctermbg=0 ctermfg=15
highlight PmenuSel ctermbg=7 ctermfg=15
highlight PmenuSbar ctermbg=8 ctermfg=15

hi MatchParen cterm=bold ctermbg=None ctermfg=Red

" Other
nnoremap <Leader>b :TagbarToggle<CR>
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
" Make Tagbar-Highlighting look nicer
highlight TagbarHighlight ctermfg=yellow

" Ultisnips
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Autocompletion
let g:deoplete#enable_at_startup = 1
" Close autocompletion preview after selected
autocmd CompleteDone * pclose!
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" ################# Running Programs ##################
autocmd FileType go nnoremap <buffer> <Leader>r :!go<Space>run<Space>%<CR> 
autocmd FileType python nnoremap <buffer> <Leader>r :!python<Space>%<CR>
autocmd FileType tex nnoremap <buffer> <Leader>r :LLPStartPreview<CR>
autocmd FileType sh nnoremap <buffer> <Leader>r :!./%<CR>
