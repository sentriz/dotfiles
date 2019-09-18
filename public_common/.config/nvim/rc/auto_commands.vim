augroup AutoCursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

augroup AutoNetrwOnStart
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END
