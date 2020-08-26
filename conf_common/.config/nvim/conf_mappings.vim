" leader
let mapleader = "\<Space>"
nnoremap          <leader>bb mzggO#!/usr/bin/env bash<esc>o<esc>`z
nnoremap          <leader>bp mzggO#!/usr/bin/env python3<esc>o<esc>`z
nnoremap          <leader>r  :write<cr>:!clear && %:p<cr>
nnoremap          <leader>x  :write<cr>:!chmod +x %:p<cr><cr>
nnoremap          <leader>n  :set hlsearch!<cr>
nnoremap          <leader>l  :set list!<cr>
nnoremap          <leader>p  :set spell!<cr>
nnoremap          <leader>s  :%s/\<<c-r><c-w>\>/<c-r><c-w>/c<c-f>$F/
nnoremap          <leader>/  :echo expand('%:p')<cr>
nnoremap <expr>   <leader>t  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/'
nnoremap <expr>   <leader>y  ':tabnew ' . expand('$DOTS_PROJECTS_DIR') . '/hippl_'
nnoremap          <leader>h  :call SyntaxAttr#SyntaxAttr()<cr>
nnoremap <silent> <leader>d  :call print_debug#print_debug()<cr>

" better
nnoremap Y y$
nnoremap Q <nop>
vnoremap yP yP

" easy folding
nnoremap        z za                            " toggle node
nnoremap <expr> Z &foldlevel == 0 ? "zR" : "zM" " toggle buffer

" bubbling
nnoremap <s-k> ddkP
nnoremap <s-j> ddp
vnoremap <s-k> xkP`[V`]
vnoremap <s-j> xp`[V`]

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
nnoremap [q :cprevious<cr>
nnoremap ]q :cnext<cr>
nnoremap [k :cprevious<cr>
nnoremap ]k :cnext<cr>
nnoremap [l :lprevious<cr>
nnoremap ]l :lnext<cr>
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [p :bprevious<cr>
nnoremap ]p :bnext<cr>
nnoremap [t :tabprevious<cr>
nnoremap ]t :tabnext<cr>

" copy above / below
inoremap <expr> <c-y> pumvisible()
    \ ? "\<c-y>"
    \ : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> pumvisible()
    \ ? "\<c-e>"
    \ : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')

" alternative escaping
inoremap jj <esc>
