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
