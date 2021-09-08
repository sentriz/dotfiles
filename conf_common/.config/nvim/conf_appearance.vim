" tree sitter will highlight
syntax off

let g:monotone_color = [10, 3, 100]
let g:monotone_secondary_hue_offset = 0
colorscheme monotone

highlight Directory gui=bold
highlight Normal guibg=none
highlight QuickFixLine guibg=#444444
highlight Pmenu guifg=#a5a1a0 guibg=#444444
highlight mkdLineBreak guifg=none guibg=none
highlight yamlKey gui=bold
highlight jsExport gui=bold

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
set fillchars=vert:\ ,eob:\ 
set sidescroll=1
set noshowmode
set laststatus=2
set signcolumn=number
set termguicolors
set mouse+=a

" statusline
highlight statusReadOnly gui=underline guifg=#f99e9e
highlight statusModifided gui=underline guifg=#f99e9e
set statusline=
set statusline+=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*   " read only flag
set statusline+=%{pathshorten(@%)}
set statusline+=%#statusModifided#%{&modified?'\ \ modified':''}%*  " modified flag
set statusline+=%=                                                  " /
set statusline+=\ column\ %c                                        " column number
