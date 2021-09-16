set listchars=tab:>\ ,trail:.
set fillchars=vert:\ ,eob:\ 
set sidescroll=1
set noshowmode
set laststatus=2
set signcolumn=number
set mouse+=a

" here trying to ask vim to only use the terminal's 16 ansi colours. then the
" theme is switched for the terminal and vim at the same time with the script
" $ theme <dark|light>
set t_Co=16
set notermguicolors
set background=dark

syntax off
syntax reset

for gr in getcompletion('', 'highlight')
    execute 'highlight clear ' .. gr
endfor

highlight LineNr        ctermfg=8
highlight Visual        ctermfg=0   ctermbg=15
highlight Search        ctermfg=0   ctermbg=11
highlight IncSearch     ctermfg=0   ctermbg=11
highlight StatusLine    ctermfg=15  ctermbg=0
highlight StatusLineNC  ctermfg=15  ctermbg=NONE
highlight CursorLine    ctermfg=0   ctermbg=11

highlight link diffAdded   DiffAdd
highlight link diffRemoved DiffDelete
highlight DiffAdd    ctermfg=2
highlight DiffDelete ctermfg=1

highlight TSKeyword          cterm=bold
highlight TSKeywordOperator  cterm=bold
highlight TSKeywordFunction  cterm=bold
highlight TSKeywordReturn    cterm=bold
highlight TSType             cterm=bold
highlight TSTypeBuiltin      cterm=bold
highlight TSRepeat           cterm=bold
highlight TSFunction         cterm=bold
highlight TSOperator         cterm=bold
highlight TSInclude          cterm=bold
highlight TSConditional      cterm=bold

highlight TSString           ctermfg=15
highlight TSComment          ctermfg=8  cterm=italic

highlight Pmenu    ctermfg=15 ctermbg=0
highlight PmenuSel ctermfg=0  ctermbg=15

sign define LspDiagnosticsSignError       text=ee texthl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning     text=ww texthl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=ii texthl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint        text=hh texthl=LspDiagnosticsSignHint

highlight LspDiagnosticsSignError           ctermfg=1
highlight LspDiagnosticsSignWarning         ctermfg=3
highlight LspDiagnosticsSignInformation     ctermfg=15
highlight LspDiagnosticsSignHint            ctermfg=2

highlight LspDiagnosticsFloatingError       ctermfg=15 cterm=bold
highlight LspDiagnosticsFloatingWarning     ctermfg=15 cterm=bold
highlight LspDiagnosticsFloatingInformation ctermfg=15 cterm=bold
highlight LspDiagnosticsFloatingHint        ctermfg=15 cterm=bold

" statusline
highlight statusReadOnly  ctermfg=9 ctermbg=0
highlight statusModifided ctermfg=9 ctermbg=0

set statusline=
set statusline+=%#statusReadOnly#%{&readonly?'\ \ read\ only\ ':''}%* " read only flag
set statusline+=\ %{pathshorten(@%)}\  
set statusline+=%#statusModifided#%{&modified?'\ modified\ ':''}%*    " modified flag
set statusline+=%=                                                    " /
set statusline+=\ column\ %c                                          " column number
