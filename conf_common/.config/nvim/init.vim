let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

filetype plugin indent off

let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:qf_auto_open_quickfix = 1
let g:qf_auto_open_loclist = 1

exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_autocmd.vim")
exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_improvements.vim")
exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_mappings.vim")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_treesitter.lua")

exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_lang_server.vim")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_lang_server.lua")

exec 'source'  . expand("$XDG_CONFIG_HOME/nvim/conf_dap.vim")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_dap.lua")
