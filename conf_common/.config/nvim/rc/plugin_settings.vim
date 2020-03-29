" helpers
function! TagbarStatusFunc(current, sort, fname, flags, ...)
    return " "
endfunction

" for Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" for netrw / tpope/vim-vinegar
let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

" for posva/vim-vue
let g:vue_disable_pre_processors=1

" for Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" for christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

" for fatih/vim-go
let g:go_updatetime = 0
let g:go_auto_sameids = 0
let g:go_fmt_command = "gofumports"
let g:go_fmt_options = {
    \ 'goimports': '-local github.com/sentriz/,senan.xyz/g/',
    \ 'gofumports': '-local github.com/sentriz/,senan.xyz/g/',
\ }
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = 'golangci-lint run --disable unused'
let g:go_disable_autoinstall = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_rename_command = 'gopls'
let g:go_doc_popup_window = 1

" for majutsushi/tagbar
let g:tagbar_status_func = 'TagbarStatusFunc'
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds' : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin' : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" for ambv/black
let g:black_linelength = 79

" for airblade/vim-rooter
let g:rooter_patterns = ['go.mod', 'go.sum', 'package.json', '.git/']
