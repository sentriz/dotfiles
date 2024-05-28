set background=dark
set notermguicolors

set listchars=tab:>\ ,trail:.
set fillchars=vert:\ ,eob:\ ,fold:\ 
set sidescroll=1
set noshowmode
set laststatus=2
set signcolumn=number
set mouse+=a

highlight clear
syntax reset

for gr in getcompletion('', 'highlight')
    execute 'highlight clear ' .. gr
endfor

" here trying to ask vim to only use the terminal's 16 ansi colours. then the
" theme is switched for the terminal and vim at the same time with the script
" $ theme <dark|light>
set t_Co=16

highlight LineNr        ctermfg=8
highlight Visual        ctermfg=0 ctermbg=15
highlight Search        ctermfg=0 ctermbg=11
highlight IncSearch     ctermfg=0 ctermbg=11
highlight StatusLine    ctermfg=0 ctermbg=15 cterm=bold
highlight StatusLineNC  ctermfg=7 ctermbg=15
highlight CursorLine    ctermfg=0 ctermbg=11
highlight MatchParen    cterm=underline
highlight Folded        ctermfg=8 cterm=italic
highlight TabLineSel    ctermbg=8
highlight NormalFloat   ctermbg=0

highlight SpellLocal ctermfg=9 cterm=underline
highlight SpellBad   ctermfg=9 cterm=underline

highlight DiffAdd    ctermfg=2
highlight DiffDelete ctermfg=1

highlight link diffAdded   DiffAdd
highlight link diffRemoved DiffDelete

highlight @keyword          cterm=bold
highlight @keyword.operator cterm=bold
highlight @keyword.function cterm=bold
highlight @keyword.return   cterm=bold
highlight @type             cterm=bold
highlight @type.builtin     cterm=bold
highlight @repeat           cterm=bold
highlight @function         cterm=bold
highlight @operator         cterm=bold
highlight @include          cterm=bold
highlight @conditional      cterm=bold
highlight @string           ctermfg=15
highlight @comment          ctermfg=8 cterm=italic

highlight Pmenu    ctermfg=15 ctermbg=0
highlight PmenuSel ctermfg=0  ctermbg=15

highlight LspReferenceText  ctermfg=11
highlight LspReferenceRead  ctermfg=11
highlight LspReferenceWrite ctermfg=11
highlight LspInlayHint      ctermfg=0

highlight DiagnosticFloatingError  ctermfg=15 cterm=bold
highlight DiagnosticFloatingHint   ctermfg=15 cterm=bold
highlight DiagnosticFloatingInfo   ctermfg=15 cterm=bold
highlight DiagnosticFloatingWarn   ctermfg=15 cterm=bold
highlight DiagnosticUnderlineError cterm=underline

highlight DiagnosticSignError ctermfg=1  cterm=bold
highlight DiagnosticSignHint  ctermfg=2  cterm=bold
highlight DiagnosticSignInfo  ctermfg=15 cterm=bold
highlight DiagnosticSignWarn  ctermfg=3  cterm=bold

sign define DiagnosticSignError text=ee  texthl=DiagnosticSignError
sign define DiagnosticSignHint  text=hh  texthl=DiagnosticSignHint
sign define DiagnosticSignInfo  text=ii  texthl=DiagnosticSignInfo
sign define DiagnosticSignWarn  text=ww  texthl=DiagnosticSignWarn

highlight TSNodeUnmatched ctermfg=0
highlight TSNodeKey       ctermfg=11 cterm=bold

highlight statusReadOnly  cterm=bold ctermfg=1 ctermbg=15
highlight statusModifided cterm=bold ctermfg=1 ctermbg=15

set statusline=
set statusline+=%#statusReadOnly#%{&readonly?'read\ only\ ':''}%*
set statusline+=%{@%}
set statusline+=%#statusModifided#%{&modified?'\ \ modified':''}%*
set statusline+=%=
set statusline+=\ column\ %c

autocmd FileType git  syntax on
autocmd FileType diff syntax on

highlight link FidgetTitle LineNr
highlight link FidgetTask  LineNr
