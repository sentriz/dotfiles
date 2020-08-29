" app colourscheme and no background please
syntax on
colorscheme monotone

highlight Directory gui=bold
highlight Normal guibg=none
highlight QuickFixLine guibg=#444444
highlight mkdLineBreak guifg=none guibg=none
highlight yamlKey gui=bold

" paren/block matching
highlight clear ParenMatch
highlight clear MatchParen
highlight MatchParen gui=bold,reverse guifg=#413e3d guibg=#f9d39e

" diffing
highlight link diffAdded DiffAdd
highlight link diffRemoved DiffDelete
highlight DiffAdd guifg=#4e9a06
highlight DiffDelete guifg=#cc0000

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
