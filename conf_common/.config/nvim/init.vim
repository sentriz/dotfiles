" enable filetype detection and plugin loading
filetype on
filetype plugin on

" plugin settings
let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'

let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1

let g:diagnostic_enable_virtual_text = 0
let g:diagnostic_insert_delay = 1
let g:diagnostic_show_sign = 1

let g:completion_enable_auto_paren = 1
let g:completion_enable_auto_hover = 0

" plugins meta
packadd! committia.vim
packadd! SyntaxAttr.vim
packadd! vim-highlightedyank
packadd! vim-hug-neovim-rpc
packadd! vim-qf
packadd! vim-tmux-navigator
packadd! nvim-lsp
packadd! diagnostic-nvim " for customising lsp messages
packadd! completion-nvim " for customising lsp completion

" plugins look
packadd! spiffy_foldtext
packadd! vim-vinegar

" plugins text
packadd! targets.vim
packadd! vim-abolish
packadd! vim-commentary
packadd! vim-exchange
packadd! vim-repeat
packadd! vim-surround

" source the rest of the rc
exec 'source' . expand("~/.config/nvim/conf_appearance.vim")
exec 'source' . expand("~/.config/nvim/conf_auto_commands.vim")
exec 'source' . expand("~/.config/nvim/conf_improvements.vim")
exec 'source' . expand("~/.config/nvim/conf_mappings.vim")
exec 'source' . expand("~/.config/nvim/conf_lang_server.vim")
