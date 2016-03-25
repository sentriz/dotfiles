" basic settings
set nocompatible
set incsearch
set noswapfile
set autowrite
set nobackup
set nowritebackup
set laststatus=2
set nowrap
syntax on
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
Plugin 'mhinz/vim-startify'
Plugin 'tommcdo/vim-exchange'
Plugin 'godlygeek/csapprox'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" plugin settings
let g:ycm_path_to_python_interpreter = "/usr/bin/python3"
let g:ycm_filetype_whitelist = {'python' : 1, 'javascript' : 1, 'c' : 1}
let g:startify_session_dir = '~/.vim/session'

" trim trailing on save
autocmd BufWritePre .vimrc,*.py,*.js,*.html call Preserve("%s/\\s\\+$//e")

" colorscheme, term colours, hidden chars and font
colorscheme desert
set guifont=Consolas:h10
set listchars=tab:>\ ,eol:¬,trail:.
set statusline=%<\ %f\ %m%r%y%w%=%l\/%-6L\ %3c

" jump to last known cursor position (except in commit messages)
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" line numbering
set nu
autocmd InsertEnter * set nornu
autocmd InsertLeave * set rnu
autocmd WinEnter * set rnu
autocmd WinLeave * set nornu

" save swapfiles in temp dir
set backupdir=$TEMP,.
set directory=$TEMP,.

" tab settings
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

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
        exec "sp " . topdir . "/" . filename
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
let mapleader = "\<Space>"

nnoremap <leader>en :e <C-R>=expand("%:p:h") . "/"<CR>
nnoremap <leader>ev :vsplit <C-R>=expand("%:p:h") . "/"<CR>
nnoremap <leader>eh :split <C-R>=expand("%:p:h") . "/"<CR>
nnoremap <leader>eg :call OpenChangedFiles()<CR>

nnoremap <leader>cg :cd /mnt/storage/dev/github/<CR>
nnoremap <leader>cd :cd /mnt/storage/media/desktop/<CR>
nnoremap <leader>cl :cd /mnt/storage/media/downloads/<CR>

nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gm :Gremove<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gbrowse!<CR>
nnoremap <leader>gv :Gmove<Space>

nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>
nnoremap <leader>du :diffupdate<CR>

nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>

" mappings
inoremap <Tab> <C-x><C-f>
nnoremap <Tab> <C-w><C-w>
nnoremap <BS> daw
map Y y$

" use C-e and C-y to copy word above and below the current line
inoremap <expr> <c-y> pumvisible() ? "\<c-y>" : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" :Q -> :q | :W -> :w
com Q q
com W w
