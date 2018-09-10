call plug#begin('~/.config/nvim/bundle')
" List of all plugins to use
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'} " Autocompletion
Plug 'scrooloose/nerdtree' " File overview
Plug 'scrooloose/syntastic' " Syntax highlighting
Plug 'tpope/vim-surround' " Surround words with parenthesis, etc...
Plug 'tpope/vim-fugitive' " Git integration for vim
Plug 'bling/vim-airline' " Infobar
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter' " Comment out code
Plug 'jiangmiao/auto-pairs' " Adds parenthesis pair instead of just ( when typing
Plug 'zchee/deoplete-go', {'do': 'make'} " Auto-completion for golang
Plug 'zchee/deoplete-jedi' " Auto-completion for python
Plug 'majutsushi/tagbar' " overview of variables, etc..
Plug 'SirVer/ultisnips' " Snippets for autocompletion, ...
Plug 'honza/vim-snippets' " Actual snippets for ultisnips
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' } " live preview for LaTeX
Plug 'zchee/deoplete-clang' " Autocompletion for C/C++
Plug 'fatih/vim-go' " go-specific tools
Plug 'w0rp/ale' " code linting
Plug 'sebdah/vim-delve' " Integration of delve, a go debugger
Plug 'Yggdroot/indentLine' " Indentation guidelines
Plug 'airblade/vim-gitgutter' " Git diff in realtime
Plug 'JamshedVesuna/vim-markdown-preview' " Markdown preview in browser
Plug 'mhinz/vim-startify' " Fancy start screen
Plug 'jceb/vim-orgmode' " Orgmode integration for vim
call plug#end()

" Initialization

"" Auto start NERD tree when opening a directory
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif

"" Auto start NERD tree if no files are specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' | endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Basic variables
filetype plugin indent on
syntax on
let mapleader = "\<space>"
set incsearch
set nohlsearch
set smartcase
set tabstop=4
set softtabstop=0
set noexpandtab
set shiftwidth=4
set nowrap
set splitright
set splitbelow
let g:deoplete#sources#go#gocode_binary = $HOME.'/go/bin/gocode'

" No line numbers in text files or console
set number
autocmd FileType txt setlocal nonumber
autocmd TermOpen * setlocal nonumber

" Make split windows look more clean
set fillchars+=vert:\ 
hi VertSplit ctermfg=Gray

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
highlight PmenuSel ctermbg=1 ctermfg=15
highlight PmenuSbar ctermbg=8 ctermfg=15

hi MatchParen cterm=bold ctermbg=None ctermfg=Red

" Other
nnoremap <Leader>b :TagbarToggle<CR>
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
" Make Tagbar-Highlighting look nicer
highlight TagbarHighlight ctermfg=yellow
set clipboard+=unnamedplus " Use the system clipboard

highlight Visual ctermbg=darkgrey cterm=bold

highlight SignColumn ctermbg=None

" Indentation guides
let g:indentLine_char = '|'
let g:indentLine_color_term = 239
let g:indentLine_fileType = ['go', 'xml', 'html', 'python', 'c', 'cpp', 'sh']

" Autocompletion
let g:deoplete#enable_at_startup = 1
" No autocompletion preview
set completeopt-=preview
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

" Faster switching of split window focus
nnoremap <silent><Leader><Left> <c-w>h 
nnoremap <silent><Leader><Right> <c-w>l 
nnoremap <silent><Leader><Up> <c-w>k
nnoremap <silent><Leader><Down> <c-w>j

nnoremap <silent><Leader>h <c-w>h 
nnoremap <silent><Leader>l <c-w>l 
nnoremap <silent><Leader>k <c-w>k
nnoremap <silent><Leader>j <c-w>j

" ################# Running Programs ##################
autocmd FileType go nnoremap <buffer> <Leader>r :!go<Space>run<Space>%<Enter>
autocmd FileType go nnoremap <buffer> <Leader>R :DlvDebug<Enter>
autocmd FileType go nnoremap <buffer> <Leader><C-r> :DlvTest<Enter>

autocmd FileType python nnoremap <buffer> <Leader>r :!python<Space>%<Enter>
autocmd FileType tex nnoremap <buffer> <Leader>r :LLPStartPreview<Enter>
autocmd FileType sh nnoremap <buffer> <Leader>r :!./%<Enter>
let vim_markdown_preview_hotkey='<Leader>r'

" ### Go specific
" Auto-Import dependencies on saving
let g:go_fmt_command = "goimports"

" Variable type info
let g:go_auto_type_info = 1

" breakpoints
autocmd FileType go nnoremap <buffer> <F9> :DlvToggleBreakpoint<Enter>
autocmd FileType go nnoremap <buffer> <F10> :DlvToggleTracepoint<Enter>

" Also remember: K for more info

" ### Ale code linting
"
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_set_highlights = 0

" ### Markdown specific
let vim_markdown_preview_toggle=2
let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_github=1

" ################## Terminal ######################

" starts a terminal inside neovim
function StartTerminal()
	vsplit | terminal
	startinsert
endfunction

" starts a file manager inside a terminal inside vim
function StartFileManager()
	split | terminal
	insert ranger
	normal $o
endfunction

" Open terminal (shell) in vsplit window and start insert mode
nnoremap <Leader>s :StartTerminal()<Enter>
nnoremap <Leader>S :StartFileManager()<Enter>
autocmd BufEnter * if &buftype == 'terminal' | startinsert | endif
autocmd BufLeave * if &buftype == 'terminal' | stopinsert | endif

" Faster switching of split window focus
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
tnoremap <C-Left> <C-\><C-N><C-w>h
tnoremap <C-Down> <C-\><C-N><C-w>j
tnoremap <C-Up> <C-\><C-N><C-w>k
tnoremap <C-Right> <C-\><C-N><C-w>l

" ################# Startify ######################

nnoremap <Leader><C-s> :Startify<Enter>

let g:startify_enable_special      = 0
let g:startify_files_number        = 8
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_update_oldfiles     = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1

let g:startify_skiplist = [
        \ 'COMMIT_EDITMSG',
        \ 'bundle/.*/doc',
        \ '/data/repo/neovim/runtime/doc',
        \ '/Users/mhi/local/vim/share/vim/vim74/doc',
        \ ]

let g:startify_bookmarks = [
        \ '~/go/src/github.com/phoenixdevelops/',
		\ '~'
        \ ]

let g:startify_custom_header =
        \ startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')


let g:startify_commands = [
    \ {'t': ['Start Terminal', 'StartTerminal()']},
	\ {'f': ['Start Filemanager', 'StartFileManager()']}
    \ ]

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240
