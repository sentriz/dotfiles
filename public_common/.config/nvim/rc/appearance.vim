" basics
set listchars=tab:>\ ,eol:¬,trail:.
set relativenumber
set sidescroll=1
set noshowmode
set laststatus=2

" statusline
set statusline=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*   " read only flag
set statusline+=%{pathshorten(@%)}
set statusline+=%#statusModifided#%{&modified?'\ \ modified':''}%* " modified flag
set statusline+=%=                                                 " /
set statusline+=\ column\ %c                                       " column number
