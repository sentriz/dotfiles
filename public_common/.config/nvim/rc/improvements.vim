" basics
set autoread
set autowrite
set backupdir=$TEMP,.
set clipboard=unnamedplus
set complete-=i
set complete-=t
set diffopt+=vertical
set directory=$TEMP,.
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
set shell=bash
set undodir=~/.cache/vimundo
set undofile
set virtualedit=block

" oopsies
command! WQ wq
command! Wq wq
command! WQa wqa
command! Wqa wqa
command! WA wa
command! Wa wa
command! W w
command! Q q
command! Qa qa
command! QA qa
