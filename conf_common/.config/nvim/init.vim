filetype plugin indent off

let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

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
set spelllang=en_gb

exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/treesitter.lua")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/lang_server.lua")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/dap.lua")

autocmd FileType markdown            setlocal spell
autocmd FileType gitcommit           setlocal spell
autocmd FileType yaml                setlocal cursorcolumn
autocmd FileType yaml.docker-compose setlocal cursorcolumn

autocmd FileType yaml                setlocal comments=:#                              commentstring=#\ %s expandtab
autocmd FileType yaml.docker-compose setlocal comments=:#                              commentstring=#\ %s expandtab
autocmd FileType python              setlocal comments=b:#,fb:-                        commentstring=#\ %s
autocmd FileType go                  setlocal comments=s1:/*,mb:*,ex:*/,://            commentstring=//\ %s
autocmd FileType lua                 setlocal comments=:--                             commentstring=--%s
autocmd FileType vim                 setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"  commentstring=\"%s
autocmd FileType sql                 setlocal comments=s1:/*,mb:*,ex:*/,:--,://
autocmd FileType sh                  setlocal commentstring=#%s
autocmd FileType dockerfile          setlocal commentstring=#%s
autocmd FileType git                 syntax on

augroup AutoCursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \     exec "normal g`\"" |
        \ endif
augroup END

augroup AutoNetrwOnStart
    autocmd!
    let have_stdin = 0
    autocmd StdinReadPost * let have_stdin = 1
    autocmd VimEnter * if !(argc() + have_stdin) | Explore! | endif
augroup END

" by Wouter Hanegraaff
augroup AutoEditGPGFile
    autocmd!
    autocmd BufReadPre,FileReadPre     *.gpg set viminfo=
    autocmd BufReadPre,FileReadPre     *.gpg set noswapfile noundofile nobackup
    autocmd BufReadPre,FileReadPre     *.gpg set bin
    autocmd BufReadPre,FileReadPre     *.gpg let ch_save = &cmdheight | set cmdheight=2
    autocmd BufReadPost,FileReadPost   *.gpg '[,']!gpg --decrypt 2>/dev/null
    autocmd BufReadPost,FileReadPost   *.gpg set nobin
    autocmd BufReadPost,FileReadPost   *.gpg let &cmdheight = ch_save | unlet ch_save
    autocmd BufReadPost,FileReadPost   *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
    autocmd BufWritePre,FileWritePre   *.gpg '[,']!gpg --default-recipient-self --armor --encrypt 2>/dev/null
    autocmd BufWritePost,FileWritePost *.gpg undo
augroup END

autocmd TextYankPost * silent! lua vim.highlight.on_yank()

" completion
set completeopt=menu,menuone,noselect
set shortmess=filnxtToOFAc

" oops
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

" leader
let mapleader = "\<Space>"
nnoremap          <leader>bb mzggO#!/usr/bin/env bash<esc>o<esc>`z
nnoremap          <leader>bp mzggO#!/usr/bin/env python3<esc>o<esc>`z
nnoremap          <leader>bj o<cr>Co-authored-by: Oskar McDermott <oskarjr@gmail.com><esc>
nnoremap          <leader>ba o<cr>Co-authored-by: E.Azer Koçulu <azer@kodfabrik.com><esc>
nnoremap          <leader>r  :write<cr>:!clear && %:p<cr>
nnoremap          <leader>x  :write<cr>:!chmod +x %:p<cr><cr>
nnoremap          <leader>n  :set hlsearch!<cr>
nnoremap          <leader>l  :set list!<cr>
nnoremap          <leader>p  :set spell!<cr>
nnoremap          <leader>s  :%s/\<<c-r><c-w>\>/<c-r><c-w>/c<c-f>$F/
nnoremap          <leader>/  :echo expand('%:p')<cr>
nnoremap <expr>   <leader>t  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/'
nnoremap <expr>   <leader>y  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/hippl_'
nnoremap <silent> <leader>d  :call print_debug#print_debug()<cr>
nnoremap <silent> <leader>h  :call SyntaxAttr#SyntaxAttr()<cr>

nnoremap <silent> <leader>qq Vip:SqlsExecuteQuery<cr>
vnoremap <silent> <leader>qq Vip:SqlsExecuteQuery<cr>
nnoremap <silent> <leader>qs :SqlsShowSchemas<cr>

" better
nnoremap Y y$
vnoremap yP yP

vnoremap u :OSCYank<cr>

" disable command hist
nnoremap Q <nop>

" easy split / quit
nnoremap <enter>       :vsplit<cr><c-w>w
nnoremap <s-enter>     :split<cr><c-w>w
nnoremap s             :write<enter>
nnoremap <silent> <c-[> <cmd>call CloseIfSaved()<cr>
nnoremap <silent> q     <cmd>call CloseIfSaved()<cr>

function! CloseIfSaved() abort
    if !&modified
        exec ":quit"
    endif
endfunction

" easy folding
set nofoldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" load current word or selection to cgn
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<cr>cgn
xnoremap <silent> s* "sy:let @/=@s<cr>cgn

" movement
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-g> :TmuxNavigatePrevious<cr>
nnoremap <up> :resize -2<cr>
nnoremap <down> :resize +2<cr>
nnoremap <left> :vertical resize +2<cr>
nnoremap <right> :vertical resize -2<cr>

" back and forth
nnoremap [p :cprevious<cr>
nnoremap ]p :cnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [o :bprevious<cr>
nnoremap ]o :bnext<cr>
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>

nnoremap ]] :cclose<cr>

" copy above / below
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" alternative escaping
inoremap jj <esc>

" very magic mode
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" dap
nnoremap <bs><bs>     <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <bs><bs><bs> <cmd>lua require'dap'.set_breakpoint(vim.fn.input('condition: '))<cr>
nnoremap <bs>9        <cmd>lua require'dap'.stop()<cr>
nnoremap <bs>0        <cmd>lua require'dap'.continue()<cr>
nnoremap <bs>=        <cmd>lua require'dap'.step_into()<cr>
nnoremap <bs>==       <cmd>lua require'dap'.step_out()<cr>
nnoremap <bs>-        <cmd>lua require'dap'.step_over()<cr>
nnoremap <bs>[        <cmd>lua require'dap'.up()<cr>
nnoremap <bs>]        <cmd>lua require'dap'.down()<cr>
nnoremap <bs>#        <cmd>lua require'dap'.repl.open()<cr>
nnoremap <bs>1        <cmd>lua require'dap'.run_last()<cr>


" lsp highlight symbol under cursor
autocmd CursorHold  <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()

" lsp mappings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga    :<c-u>lua vim.lsp.buf.range_code_action()<cr>
vnoremap <silent> gt    <cmd>lua vim.diagnostic.setqflist()<cr>
inoremap <silent> <c-s> <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> J     <cmd>lua vim.diagnostic.open_float()<cr>
nnoremap <silent> H     <cmd>lua vim.diagnostic.goto_prev()<cr>
nnoremap <silent> L     <cmd>lua vim.diagnostic.goto_next()<cr>
