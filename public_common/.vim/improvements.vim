" basics
set autoread
set autowrite
set clipboard=unnamedplus
set complete-=i
set complete-=t
set diffopt+=vertical
set ignorecase
set incsearch
set laststatus=2
set nobackup
set nocompatible
set noswapfile
set nowrap
set nowritebackup
set number
set path+=**
set shell=bash
set undodir=~/.cache/vimundo
set undofile
set wildmenu
set directory=$TEMP,.
set backupdir=$TEMP,.
set mouse+=a
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" oopsies
command WQ wq
command Wq wq
command WQa wqa
command Wqa wqa
command W w
command Q q
