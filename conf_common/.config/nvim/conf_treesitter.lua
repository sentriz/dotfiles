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

local textobjects_select = {
	enable = true,
	keymaps = {
		["ib"] = "@block.inner",
		["ab"] = "@block.outer",
		["ic"] = "@call.inner",
		["ac"] = "@call.outer",
		["ic"] = "@class.inner",
		["ac"] = "@class.outer",
		["id"] = "@conditional.inner",
		["ad"] = "@conditional.outer",
		["if"] = "@function.inner",
		["af"] = "@function.outer",
		["ia"] = "@parameter.inner",
		["aa"] = "@parameter.outer",
	},
}

local textobjects_swap = {
	enable = true,
	swap_next = {
		["ta"] = "@parameter.inner",
		["tf"] = "@function.outer",
		["tb"] = "@block.outer",
	},
	swap_previous = {
		["tA"] = "@parameter.inner",
		["tF"] = "@function.outer",
		["tB"] = "@block.outer",
	},
}

local textobjects_move = {
	enable = true,
	goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
	goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
	goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
	goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
}

local textobjects = {
	enable = true,
	select = textobjects_select,
	move = textobjects_move,
	swap = textobjects_swap,
}

configs.setup({
	ensure_installed = "maintained",
	highlight = highlight,
	indent = indent,
	incremental_selection = incremental_selection,
	textobjects = textobjects,
})
