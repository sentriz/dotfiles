autocmd FileType markdown            ++once setlocal spell
autocmd FileType gitcommit           ++once setlocal spell
autocmd FileType yaml                ++once setlocal cursorcolumn
autocmd FileType yaml.docker-compose ++once setlocal cursorcolumn

autocmd FileType yaml                ++once setlocal comments=:#                              commentstring=#\ %s
autocmd FileType yaml.docker-compose ++once setlocal comments=:#                              commentstring=#\ %s
autocmd FileType python              ++once setlocal comments=b:#,fb:-                        commentstring=#\ %s
autocmd FileType go                  ++once setlocal comments=s1:/*,mb:*,ex:*/,://            commentstring=//\ %s
autocmd FileType lua                 ++once setlocal comments=:--                             commentstring=--%s
autocmd FileType vim                 ++once setlocal comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",:\"  commentstring=\"%s
autocmd FileType sql                 ++once setlocal comments=s1:/*,mb:*,ex:*/,:--,://

autocmd BufReadPost * ++once
            \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

let have_stdin = 0
autocmd StdinReadPost * ++once let have_stdin = 1
autocmd VimEnter      * ++once if !(argc() + have_stdin) | Explore! | endif

" by Wouter Hanegraaff
autocmd BufReadPre,FileReadPre     *.gpg ++once set viminfo=
autocmd BufReadPre,FileReadPre     *.gpg ++once set noswapfile noundofile nobackup
autocmd BufReadPre,FileReadPre     *.gpg ++once set bin
autocmd BufReadPre,FileReadPre     *.gpg ++once let ch_save = &cmdheight | set cmdheight=2
autocmd BufReadPost,FileReadPost   *.gpg ++once '[,']!gpg --decrypt 2>/dev/null
autocmd BufReadPost,FileReadPost   *.gpg ++once set nobin
autocmd BufReadPost,FileReadPost   *.gpg ++once let &cmdheight = ch_save | unlet ch_save
autocmd BufReadPost,FileReadPost   *.gpg ++once execute ":doautocmd BufReadPost " . expand("%:r")
autocmd BufWritePre,FileWritePre   *.gpg ++once '[,']!gpg --default-recipient-self --armor --encrypt 2>/dev/null
autocmd BufWritePost,FileWritePost *.gpg ++once undo

autocmd BufWritePost * ++once silent! FormatWrite
