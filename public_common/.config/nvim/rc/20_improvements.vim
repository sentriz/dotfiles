" basics
set autoread
set autowrite
set clipboard=unnamedplus
set complete-=i
set complete-=t
set diffopt+=vertical
set ignorecase
set incsearch
set inccommand=nosplit
set laststatus=2
set nobackup
set noswapfile
set nowrap
set nowritebackup
set number
set path+=**
set shell=bash
set undodir=~/.cache/vimundo
set undofile
set directory=$TEMP,.
set backupdir=$TEMP,.
set mouse+=a

" oopsies
command WQ wq
command Wq wq
command WQa wqa
command Wqa wqa
command WA wa
command Wa wa
command W w
command Q q
