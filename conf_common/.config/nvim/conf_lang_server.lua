--# selene: allow(undefined_variable, unscoped_variables)
--# for list of lsp, linter, and formatter tools, see $XDG_CONFIG_HOME/packages

local lspconfig = require("lspconfig")
local cmp = require("cmp")
local sqlsp = require("sqls")
local nullls = require("null-ls")

vim.diagnostic.config({ virtual_text = false })

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "tmux" },
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<c-x><c-o>"] = cmp.mapping.complete(),
		["<c-space>"] = cmp.mapping.complete(),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<cr>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<c-e>"] = cmp.mapping.close(),
	},
})

-- when using pylint or pyright, make sure we're in the right venv. eg
-- $ source $PYTHON_VENVS_DIR/<venv>/bin/activate.fish
-- $ pip install -r requirements-dev.txt .
-- $ which pylint
-- $ which pyright

local function no_format_please(client)
	client.resolved_capabilities.document_formatting = false
	client.resolved_capabilities.document_range_formatting = false
end

lspconfig.pyright.setup({
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
			venvPath = os.getenv("PYTHON_VENVS_DIR"),
		},
	},
})

lspconfig.gopls.setup({
	settings = {
		gopls = {
			usePlaceholders = true,
			completeUnimported = true,
			deepCompletion = true,
		},
	},
	on_attach = no_format_please,
})

lspconfig.sqls.setup({
	cmd = { "sqls", "-config", ".sqls.yml" },
	on_attach = function(client)
		client.resolved_capabilities.execute_command = true
		client.commands = sqlsp.commands
		sqlsp.setup({})
		no_format_please(client)
	end,
})

lspconfig.clangd.setup({})
lspconfig.dockerls.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.bashls.setup({ on_attach = no_format_please })
lspconfig.tsserver.setup({ on_attach = no_format_please })
lspconfig.volar.setup({ on_attach = no_format_please })

nullls.setup({
	log = { enable = false },
	sources = {
		nullls.builtins.formatting.black,
		nullls.builtins.formatting.fish_indent,
		nullls.builtins.formatting.markdownlint,
		nullls.builtins.formatting.pg_format.with({ extra_args = { "--keyword-case", 1, "--type-case", 1 } }),
		nullls.builtins.formatting.prettierd,
		nullls.builtins.formatting.shfmt.with({ extra_args = { "-i", 4, "-bn" } }),
		nullls.builtins.formatting.stylua,
		nullls.builtins.formatting.goimports,

		nullls.builtins.diagnostics.eslint_d,
		nullls.builtins.diagnostics.golangci_lint,
		nullls.builtins.diagnostics.hadolint.with({ extra_args = { "--ignore", "DL3018", "--ignore", "DL3008" } }),
		nullls.builtins.diagnostics.markdownlint,
		nullls.builtins.diagnostics.pylint,
		nullls.builtins.diagnostics.selene,
		nullls.builtins.diagnostics.shellcheck,
	},
})
