" basics
set autoread
set autowriteall
set backupdir=$TEMP,.
set clipboard^=unnamed,unnamedplus
set complete-=i
set complete-=t
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
set updatetime=300
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
