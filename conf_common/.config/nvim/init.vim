exec 'source' . expand("$XDG_CONFIG_HOME/nvim/conf_plugins.vim")
exec 'source' . expand("$XDG_CONFIG_HOME/nvim/conf_appearance.vim")
exec 'source' . expand("$XDG_CONFIG_HOME/nvim/conf_auto_commands.vim")
exec 'source' . expand("$XDG_CONFIG_HOME/nvim/conf_improvements.vim")
exec 'source' . expand("$XDG_CONFIG_HOME/nvim/conf_mappings.vim")

exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_lang_server.lua")
exec 'luafile' . expand("$XDG_CONFIG_HOME/nvim/conf_formatters.lua")
