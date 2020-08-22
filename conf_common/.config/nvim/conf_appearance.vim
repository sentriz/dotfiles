" app colourscheme and no background please
syntax on
colorscheme monotone
highlight Normal guibg=none ctermbg=none

" basics
set listchars=tab:>\ ,trail:.
set fillchars=vert:\ 
set sidescroll=1
set noshowmode
set laststatus=2
set signcolumn=number
set termguicolors
set fcs=eob:\ 

" statusline
set statusline=
set statusline+=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*   " read only flag
set statusline+=%{pathshorten(@%)}
set statusline+=%#statusModifided#%{&modified?'\ \ modified':''}%*  " modified flag
set statusline+=%=                                                  " /
set statusline+=\ column\ %c                                        " column number
