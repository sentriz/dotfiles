" basic settings
set nocompatible
set autoread
set incsearch
set hlsearch
set noswapfile
set clipboard=unnamed
set autowrite
set nobackup
set nowritebackup
set laststatus=2
set sidescroll=1
set nowrap
set wildmode=longest,list,full
set wildmenu
set mouse+=a
set shell=bash
set path+=**
set complete-=t
set complete-=i

syntax on
filetype off

" vundle setup
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" syntax
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'aliva/vim-fish'
" nav
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
" quiet
Plugin 'godlygeek/csapprox'
" vis
Plugin 'mhinz/vim-startify'
" text
Plugin 'tpope/vim-repeat'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
" ide
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
    " Plugin 'davidhalter/jedi-vim'
    call vundle#end()

    " vundle finish
    filetype plugin indent on

    " plugin settings
    let g:startify_session_dir = '~/.vim/session'
    let g:netrw_winsize = -28
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_sort_sequence = '[\/]$,*'
    let g:netrw_altv = 1
    let g:netrw_browse_split = 0
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_custom_ignore = '\*.pyc'
    let g:ctrlp_prompt_mappings = {
        \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
        \ 'AcceptSelection("t")': ['<cr>'],
        \ }
    let g:go_fmt_command = "goimports"

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
    set expandtab
    set shiftwidth=4
    set softtabstop=4

    " text bubbling
    nmap <S-k> ddkP
    nmap <S-j> ddp
    vmap <S-k> xkP`[V`]
    vmap <S-j> xp`[V`]

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

    nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/"<CR>
    nnoremap <leader>ev :vsplit <C-R>=expand("%:p:h") . "/"<CR>
    nnoremap <leader>eh :split <C-R>=expand("%:p:h") . "/"<CR>
    nnoremap <leader>en :Lexplore<CR>
    nnoremap <leader>eg :call OpenChangedFiles()<CR>

    nnoremap <leader>cg :cd ~/dev/github/<CR>
    nnoremap <leader>cd :cd ~/desktop/<CR>
    nnoremap <leader>cl :cd ~/downloads/<CR>

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

    nnoremap <leader>bb mzggO#!/usr/bin/env bash<Esc>o<Esc>`z
    nnoremap <leader>bp mzggO#!/usr/bin/env python3<Esc>o<Esc>`z

    nnoremap <leader>a :ArgWrap<CR>
    nnoremap <leader>h :ColorToggle<CR>
    nnoremap <leader>r :w<CR>:!clear && %:p<CR>
nnoremap <leader>x :w<CR>:!chmod +x %:p<CR><CR>
" nnoremap <leader>t :w<CR>:!ctags -R %:h<CR><CR>
nnoremap <leader>n :noh<CR>

nnoremap <leader>s :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/

nnoremap [25~ :bp<CR>
nnoremap [26~ :bn<CR>
nnoremap Y y$

nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

" use C-e and C-y to copy word above and below the current line
inoremap <expr> <c-y> pumvisible() ? "\<c-y>" : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" :Q -> :q | :W -> :w
com Q q
com W w
