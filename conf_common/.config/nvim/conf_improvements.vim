" basics
set tabstop=4
set virtualedit=block
set number
set nowrap
set autoread
set clipboard^=unnamed,unnamedplus
set diffopt+=vertical
set gdefault
set ignorecase
set inccommand=nosplit
set incsearch
set grepprg=rg\ --vimgrep\ --hidden
set updatetime=300
set scrolloff=5
set autowriteall
set noswapfile
set undodir=~/.cache/vimundo
set undofile
set nowritebackup
set nobackup

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
