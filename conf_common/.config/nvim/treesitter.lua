local context = require("treesitter-context")
local configs = require("nvim-treesitter.configs")

local highlight = {
	enable = true,
	use_languagetree = true,
	additional_vim_regex_highlighting = false,
}

local indent = { enable = true }

local incremental_selection = {
	enable = true,
	keymaps = {
		init_selection = "=",
		node_incremental = "=",
		node_decremental = "-",
		scope_incremental = "+",
	},
}

configs.setup({
	ensure_installed = "all",
	highlight = highlight,
	indent = indent,
	incremental_selection = incremental_selection,
})

context.setup({
	enable = true,
	throttle = true,
	max_lines = 0,
	patterns = {
		default = {
			"class",
			"function",
			"method",
		},
	},
})
