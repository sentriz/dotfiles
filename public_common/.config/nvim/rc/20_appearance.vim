set listchars=tab:>\ ,eol:¬,trail:.
set relativenumber
set sidescroll=1
set noshowmode
set laststatus=2
set statusline=
set statusline+=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*
set statusline+=%f
set statusline+=%#statusModifided#%{&modified?'\ modified':''}%*
set statusline+=%=
set statusline+=\ column\ %c

syntax on
colorscheme custom
