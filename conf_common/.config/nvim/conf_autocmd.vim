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
