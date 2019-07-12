augroup AutoCursorLastPosition
    autocmd! AutoCursorLastPosition
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

augroup AutoBlack
    autocmd! AutoBlack
    autocmd BufWritePre *.py
        \ execute ':Black'
augroup END

augroup AutoNetrwOnStart
    autocmd!
    autocmd VimEnter * if argc() == 0 | Explore! | endif
augroup END
