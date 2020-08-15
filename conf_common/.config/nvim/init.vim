" enable filetype detection and plugin loading
filetype on
filetype plugin on

" plugin settings
let g:netrw_list_hide = '.*\.pyc$,^__pycache__$'
let g:tmux_navigator_no_mappings = 1
let g:tmux_navigator_save_on_switch = 1
let g:SpiffyFoldtext_format = "%c{ } ... }%f{ }"

" plugins meta
packadd! committia.vim
packadd! nvim-yarp
packadd! SyntaxAttr.vim
packadd! vim-highlightedyank
packadd! vim-hug-neovim-rpc
packadd! vim-qf
packadd! vim-tmux-navigator
packadd! nvim-lsp

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
exec 'source' . expand("~/.config/nvim/rc/appearance.vim")
exec 'source' . expand("~/.config/nvim/rc/auto_commands.vim")
exec 'source' . expand("~/.config/nvim/rc/improvements.vim")
exec 'source' . expand("~/.config/nvim/rc/mappings.vim")
exec 'source' . expand("~/.config/nvim/rc/lang_server.vim")
