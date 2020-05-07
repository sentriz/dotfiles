" for netrw / tpope/vim-vinegar
let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

" for christoomey/vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

" for fatih/vim-go
let g:go_auto_sameids = 0
let g:go_def_mode = 'gopls'
let g:go_disable_autoinstall = 1
let g:go_doc_popup_window = 1
let g:go_fmt_command = "gofumports"
let g:go_fmt_options = {
    \ 'goimports': '-local github.com/sentriz/,senan.xyz/g/,go.senan.xyz',
    \ 'gofumports': '-local github.com/sentriz/,senan.xyz/g/,go.senan.xyz',
\ }
let g:go_gopls_local = 'go.senan.xyz'
let g:go_highlight_build_constraints = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_info_mode = 'gopls'
let g:go_metalinter_autosave = 0
let g:go_metalinter_command = 'golangci-lint'
let g:go_rename_command = 'gopls'
let g:go_updatetime = 0

" for ambv/black
let g:black_linelength = 79

" for airblade/vim-rooter
let g:rooter_patterns = ['go.mod', 'go.sum', 'package.json', '.git/']
