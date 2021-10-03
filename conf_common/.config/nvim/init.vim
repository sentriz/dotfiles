filetype plugin indent off

let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_improvements.vim")
exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_mappings.vim")
exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_lang_server.vim")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_lang_server.lua")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_treesitter.lua")
