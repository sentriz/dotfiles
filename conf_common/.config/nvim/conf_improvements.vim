" enable filetype detection and plugin loading
filetype on
filetype plugin on

" basics
set autoread
set autowriteall
set backupdir=$TEMP,.
set clipboard^=unnamed,unnamedplus
set diffopt+=vertical
set directory=$TEMP,.
set foldmethod=syntax
set gdefault
set ignorecase
set inccommand=nosplit
set incsearch
set laststatus=2
set mouse+=a
set nobackup
set nofoldenable
set noswapfile
set nowrap
set nowritebackup
set number
set path+=**
set scrolloff=5
set shell=bash
set undodir=~/.cache/vimundo
set undofile
set virtualedit=block
set grepprg=rg\ --vimgrep\ --hidden
set tabstop=4

" completion / lsp
set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect
set shortmess+=c

" oopsies
command! Q quit
command! QA qall
command! Qa qall
command! W write
command! WA wall
command! Wa wall
command! WQ wq
command! Wq wq
command! WQa wqall
command! Wqa wqall
command! VS vsplit
command! Vs vsplit
