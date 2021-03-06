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

" better
nnoremap Y y$
vnoremap yP yP

vnoremap u :OSCYank<cr>

" disable command hist
nnoremap Q <nop>
nnoremap q: <nop>

" easy folding
set nofoldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
nnoremap        z za                            " toggle node
nnoremap <expr> Z &foldlevel == 0 ? "zR" : "zM" " toggle buffer
nnoremap z=     z=                              " fix spell bind

" load current word or selection to cgn
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<cr>cgn
xnoremap <silent> s* "sy:let @/=@s<cr>cgn

" bubbling
vnoremap K xkP`[V`]
vnoremap J xp`[V`]

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

" copy above / below
inoremap <expr> <c-y> matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" alternative escaping
inoremap jj <esc>
