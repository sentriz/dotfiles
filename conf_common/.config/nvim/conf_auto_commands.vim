autocmd FileType markdown            setlocal spell
autocmd FileType gitcommit           setlocal spell
autocmd FileType yaml                setlocal cursorcolumn
autocmd FileType yaml.docker-compose setlocal cursorcolumn

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

augroup AutoFormat
    autocmd!
    autocmd BufWritePost * silent! FormatWrite
augroup END
