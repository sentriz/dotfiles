augroup AutoCursorLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END

augroup AutoNetrwOnStart
    autocmd!
    let have_stdin = 0
    autocmd StdinReadPost * let have_stdin = 1
    autocmd VimEnter * if !(argc() + have_stdin) | Explore! | endif
augroup END
