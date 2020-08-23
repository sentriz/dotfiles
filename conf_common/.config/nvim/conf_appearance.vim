" app colourscheme and no background please
syntax on
colorscheme monotone

" no background
highlight Normal guibg=none

" paren/block matching
highlight clear ParenMatch
highlight clear MatchParen
highlight MatchParen gui=bold,reverse guifg=#413e3d guibg=#f9d39e

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
