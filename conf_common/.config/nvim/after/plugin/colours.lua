--# selene: allow(undefined_variable, unscoped_variables)

-- colors and appearance
vim.opt.background = "dark"
vim.opt.termguicolors = false

vim.opt.listchars = { tab = "> ", trail = "." }
vim.opt.fillchars = { vert = " ", eob = " ", fold = " " }
vim.opt.sidescroll = 1
vim.opt.showmode = false
vim.opt.laststatus = 2
vim.opt.signcolumn = "number"
vim.opt.mouse = "a"

-- clear all highlights
vim.cmd("highlight clear")
vim.cmd("syntax reset")

local groups_to_clear = vim.fn.getcompletion("", "highlight")
if #groups_to_clear > 0 then
	local clear_commands = {}
	for _, group in ipairs(groups_to_clear) do
		table.insert(clear_commands, "highlight clear " .. group)
	end
	vim.cmd(table.concat(clear_commands, " | "))
end

-- here trying to ask vim to only use the terminal's 16 ansi colours. then the
-- theme is switched for the terminal and vim at the same time with the script
-- $ theme <dark|light>
vim.cmd("set t_Co=16")

-- basic highlights
vim.api.nvim_set_hl(0, "Normal", {})
vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 8 })
vim.api.nvim_set_hl(0, "Visual", { ctermfg = 0, ctermbg = 15 })
vim.api.nvim_set_hl(0, "Search", { ctermfg = 0, ctermbg = 11 })
vim.api.nvim_set_hl(0, "IncSearch", { ctermfg = 0, ctermbg = 11 })
vim.api.nvim_set_hl(0, "StatusLine", { ctermfg = 0, ctermbg = 15, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { ctermfg = 7, ctermbg = 15 })
vim.api.nvim_set_hl(0, "CursorLine", { ctermfg = 0, ctermbg = 11 })
vim.api.nvim_set_hl(0, "CursorColumn", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "MatchParen", { underline = true })
vim.api.nvim_set_hl(0, "Folded", { ctermfg = 8, italic = true })
vim.api.nvim_set_hl(0, "TabLineSel", { ctermbg = 8 })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "QuickFixLine", { ctermbg = 0 })

-- spelling
vim.api.nvim_set_hl(0, "SpellLocal", { ctermfg = 9, underline = true })
vim.api.nvim_set_hl(0, "SpellBad", { ctermfg = 9, underline = true })

-- diff colors
vim.api.nvim_set_hl(0, "DiffAdd", { ctermfg = 2 })
vim.api.nvim_set_hl(0, "DiffDelete", { ctermfg = 1 })

vim.api.nvim_set_hl(0, "diffAdded", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "diffRemoved", { link = "DiffDelete" })

-- treesitter highlights
vim.api.nvim_set_hl(0, "@keyword", { bold = true })
vim.api.nvim_set_hl(0, "@keyword.operator", { bold = true })
vim.api.nvim_set_hl(0, "@keyword.function", { bold = true })
vim.api.nvim_set_hl(0, "@keyword.return", { bold = true })
vim.api.nvim_set_hl(0, "@type", { bold = true })
vim.api.nvim_set_hl(0, "@type.builtin", { bold = true })
vim.api.nvim_set_hl(0, "@repeat", { bold = true })
vim.api.nvim_set_hl(0, "@function", { bold = true })
vim.api.nvim_set_hl(0, "@operator", { bold = true })
vim.api.nvim_set_hl(0, "@include", { bold = true })
vim.api.nvim_set_hl(0, "@conditional", { bold = true })
vim.api.nvim_set_hl(0, "@string", { ctermfg = 15 })
vim.api.nvim_set_hl(0, "@comment", { ctermfg = 8, italic = true })

vim.api.nvim_set_hl(0, "@diff.plus", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "@diff.minus", { link = "DiffDelete" })

-- completion menu
vim.api.nvim_set_hl(0, "Pmenu", { ctermfg = 15, ctermbg = 0 })
vim.api.nvim_set_hl(0, "PmenuSel", { ctermfg = 0, ctermbg = 15 })

-- lsp highlights
vim.api.nvim_set_hl(0, "LspReferenceText", { ctermfg = 11 })
vim.api.nvim_set_hl(0, "LspReferenceRead", { ctermfg = 11 })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { ctermfg = 11 })
vim.api.nvim_set_hl(0, "LspInlayHint", { ctermfg = 0 })

-- diagnostic highlights
vim.api.nvim_set_hl(0, "DiagnosticFloatingError", { ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingHint", { ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingInfo", { ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticFloatingWarn", { ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { ctermfg = 1, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { ctermfg = 2, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { ctermfg = 15, bold = true })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { ctermfg = 3, bold = true })

-- diagnostic signs
vim.fn.sign_define("DiagnosticSignError", { text = "ee", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignHint", { text = "hh", texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ii", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "ww", texthl = "DiagnosticSignWarn" })

-- treesitter playground
vim.api.nvim_set_hl(0, "TSNodeUnmatched", { ctermfg = 0 })
vim.api.nvim_set_hl(0, "TSNodeKey", { ctermfg = 11, bold = true })

-- statusline highlights
vim.api.nvim_set_hl(0, "statusReadOnly", { bold = true, ctermfg = 1, ctermbg = 15 })
vim.api.nvim_set_hl(0, "statusModifided", { bold = true, ctermfg = 1, ctermbg = 15 })

-- statusline configuration
vim.opt.statusline = ""
vim.opt.statusline:append("%#statusReadOnly#%{&readonly?'read only ':''}%*")
vim.opt.statusline:append("%{@%}")
vim.opt.statusline:append("%#statusModifided#%{&modified?'  modified':''}%*")
vim.opt.statusline:append("%=")
vim.opt.statusline:append(" column %c")
