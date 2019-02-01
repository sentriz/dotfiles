" basics
syntax on
colorscheme custom
set listchars=tab:>\ ,eol:¬,trail:.
set relativenumber
set sidescroll=1
set noshowmode
set laststatus=2

" statusline helpers
function ShortFileName()
  return expand('%:p:h:t') . "/" . expand('%:t')
endfunction

" statusline
set statusline=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*   " read only flag
set statusline+=%{ShortFileName()}                                 " the short filename
set statusline+=%#statusModifided#%{&modified?'\ \ modified':''}%* " modified flag
set statusline+=%=                                                 " /
set statusline+=\ column\ %c                                       " column number
