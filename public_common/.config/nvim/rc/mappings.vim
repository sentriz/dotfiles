" leader
let mapleader = "\<Space>"
nnoremap <leader>bb mzggO#!/usr/bin/env bash<Esc>o<Esc>`z
nnoremap <leader>bp mzggO#!/usr/bin/env python3<Esc>o<Esc>`z
nnoremap <leader>r :w<CR>:!clear && %:p<CR>
nnoremap <leader>x :w<CR>:!chmod +x %:p<CR><CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>s :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/
nnoremap <leader>t :TagbarToggle<CR>
nnoremap <leader>f :GFiles<CR>
nnoremap <leader>l :Rg<CR>

" better
nnoremap Y y$

" 'bubbling'
nnoremap <S-k> ddkP
nnoremap <S-j> ddp
vnoremap <S-k> xkP`[V`]
vnoremap <S-j> xp`[V`]

" movement
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-g> :TmuxNavigatePrevious<cr>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" lists (quickfix, location list, buffer)
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [l :lprevious<CR>
nnoremap ]l :lnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>

" copy above / below
inoremap <expr> <c-y> pumvisible()
    \ ? "\<c-y>"
    \ : matchstr(getline(line('.')-1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
inoremap <expr> <c-e> pumvisible()
    \ ? "\<c-e>"
    \ : matchstr(getline(line('.')+1), '\%' . virtcol('.') . 'v\%(\k\+\\|.\)')
