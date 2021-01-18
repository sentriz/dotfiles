exec 'source' . expand("~/.config/nvim/conf_plugins.vim")
exec 'source' . expand("~/.config/nvim/conf_appearance.vim")
exec 'source' . expand("~/.config/nvim/conf_auto_commands.vim")
exec 'source' . expand("~/.config/nvim/conf_improvements.vim")
exec 'source' . expand("~/.config/nvim/conf_mappings.vim")

exec 'luafile' . expand("~/.config/nvim/conf_lang_server.lua")
exec 'luafile' . expand("~/.config/nvim/conf_formatters.lua")
