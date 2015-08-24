set nocompatible
syntax on
set noswapfile
set autowrite
set nobackup
set nowritebackup
filetype off

if has("win32")
    source $VIMRUNTIME/mswin.vim
    behave mswin
    " vundle setup
    set rtp+=~\vimfiles\bundle\vundle\
else
    " vundle setup
    set rtp+=~/.vim/bundle/Vundle.vim
endif

" plugins via vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'godlygeek/csapprox'
"Plugin 'klen/python-mode'
call vundle#end()
filetype plugin indent on

" trim trailing on save
autocmd BufWritePre *vimrc,*py,*.js,*.html call Preserve("%s/\\s\\+$//e")

" statusline
set statusline+=%{fugitive#statusline()}
set laststatus=2

" colorscheme, term colours, hidden chars and font
set t_Co=256
"colorscheme obsidian2
colorscheme desert
set guifont=Consolas:h10
set listchars=tab:>\ ,eol:¬,trail:.

" highlight >79 col
augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%79v.*/
    autocmd FileType python set nowrap
augroup END
" line numbering
set nu
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu
autocmd WinEnter * set rnu
autocmd WinLeave * set nornu

" tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" save swapfiles in temp dir
set backupdir=$TEMP,.
set directory=$TEMP,.

" text bubbling
nmap <C-k> ddkP
nmap <C-j> ddp
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" functions
function! OpenChangedFiles()
    only
    let status = system('git status -s | grep "^ \?\(M\|A\)" | cut -d " " -f 3')
    let filenames = split(status, "\n")
    let topdir = split(system('git rev-parse --show-toplevel'), "\n")[0]
    if len(filenames) < 1
        let status = system('git show --pretty="format:" --name-only')
        let filenames = split(status, "\n")
    endif
    exec "edit " . topdir . "/" . filenames[0]
    for filename in filenames[1:]
        if len(filenames) > 4
            exec "tabedit " . topdir . "/" . filename
        else
            exec "sp " . topdir . "/" . filename
        endif
    endfor
endfunction

function! Preserve(command)
  let search = @/
  let cursor = getpos(".")
  execute a:command
  let @/ = search
  call setpos(".", cursor)
endfunction

" leader mappings
map <leader>o :call OpenChangedFiles()<CR>
map <leader>cg :cd /mnt/storage/dev/github/<CR>
map <leader>cd :cd /mnt/storage/media/desktop/<CR>
map <leader>cl :cd /mnt/storage/media/downloads/<CR>
map <leader>l :set list!<CR>
map <leader><leader> :noh<CR>
map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

imap <leader>{ {<CR><Esc>o}<Esc>k4i<Space><Esc>A

" mappings
imap <Tab> <C-x><C-f>
nnoremap <Tab> <C-w><C-w>

" jump to last known cursor position (except in commit messages)
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
