" basic settings
set nocompatible
set autoread
set incsearch
set noswapfile
set clipboard=unnamedplus
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
set diffopt+=vertical
set undofile
set undodir=~/.cache/vimundo
syntax on

" vundle setup
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'aliva/vim-fish'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'mhinz/vim-startify'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'posva/vim-vue'
Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplete.vim'
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on

" plugin settings
let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'
let g:hardtime_default_on = 1
let g:startify_session_dir = '~/.vim/session'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn|pyc|png|jpg))$'
let g:go_fmt_command = "goimports"
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:neocomplete#enable_at_startup = 1
let g:vue_disable_pre_processors=1
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" colorscheme, term colours, hidden chars and font
colorscheme custom
set listchars=tab:>\ ,eol:¬,trail:.
set fillchars+=vert:│
set statusline=%<\ %f\ %m%r%y%w%=%l\/%-6L\ %3c

" jump to last known cursor position (except in commit messages)
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" line numbering
set number relativenumber
" autocmd InsertEnter * set nornu
" autocmd InsertLeave * set rnu
" autocmd WinEnter * set rnu
" autocmd WinLeave * set nornu

" save swapfiles in temp dir
set backupdir=$TEMP,.
set directory=$TEMP,.

" text bubbling
nmap <S-k> ddkP
nmap <S-j> ddp
vmap <S-k> xkP`[V`]
vmap <S-j> xp`[V`]

" functions
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
nnoremap <leader>bb mzggO#!/usr/bin/env bash<Esc>o<Esc>`z
nnoremap <leader>bp mzggO#!/usr/bin/env python3<Esc>o<Esc>`z
nnoremap <leader>r :w<CR>:!clear && %:p<CR>
nnoremap <leader>x :w<CR>:!chmod +x %:p<CR><CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>s :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/
nnoremap <leader>t :TagbarToggle<CR>
nnoremap [25~ :bp<CR>
nnoremap [26~ :bn<CR>
nnoremap Y y$
" nnoremap <Left> :vertical resize +2<CR>
" nnoremap <Right> :vertical resize -2<CR>
" nnoremap <Up> :resize -2<CR>
" nnoremap <Down> :resize +2<CR>

" use C-e and C-y to copy word above and below the current line
inoremap <expr> <c-y> pumvisible() ? "\<c-y>" : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> pumvisible() ? "\<c-e>" : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" :Q -> :q | :W -> :w
com Q q
com W w
com Wa wa

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-g> :TmuxNavigatePrevious<cr>

if has("mouse_sgr")
	set ttymouse=sgr
else
	set ttymouse=xterm2
end
