" basics
set autoread
set autowriteall
set backupdir=$TEMP,.
set clipboard^=unnamed,unnamedplus
set diffopt+=vertical
set directory=$TEMP,.
set gdefault
set ignorecase
set inccommand=nosplit
set incsearch
set laststatus=2
set mouse+=a
set nobackup
set noswapfile
set nowrap
set nowritebackup
set number
set path+=**
set scrolloff=5
set undodir=~/.cache/vimundo
set undofile
set virtualedit=block
set grepprg=rg\ --vimgrep\ --hidden
set tabstop=4
set updatetime=300

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
