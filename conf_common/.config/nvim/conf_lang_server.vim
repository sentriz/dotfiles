lua <<EOF
local lsp        = require "nvim_lsp"
local configs    = require "nvim_lsp/configs"
local util       = require "nvim_lsp/util"
local diagnostic = require "diagnostic"
local completion = require "completion"

local sync_timeout = 1000

function document_format_sync()
    vim.lsp.buf.formatting_sync(nil, sync_timeout)
end

function document_organise_sync()
    local params = vim.lsp.util.make_range_params()
    params.context = {source = {organizeImports = true}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, sync_timeout)
    if not result then return end
    result = result[1].result
    if not result then return end
    edit = result[1].edit
    vim.lsp.util.apply_workspace_edit(edit)
end

function document_format_and_organise_sync()
    document_format_sync()
    document_organise_sync()
end

-- -- go -- --
configs.custom_go = {
    default_config = {
        cmd = {"gopls"},
        filetypes = {"go"},
        root_dir = util.root_pattern("go.mod", ".git"),
        settings = {
            gopls = {
                usePlaceholders = true,
                completeUnimported = true,
                deepCompletion = true,
                staticcheck = true
            }
        }
    }
}

-- -- python -- --
configs.custom_python = {
    default_config = {
        cmd = {"python3", "-m", "pyls"},
        filetypes = {"python"},
        root_dir = util.root_pattern("requirements.txt", "pyproject.toml", "Pipfile", ".git"),
        settings = {
            pyls = {
                configurationSources = {"flake8"}
            }
        }
    }
}

-- -- typescript -- --
configs.custom_typescript = {
    default_config = {
        cmd = {"typescript-language-server", "--stdio"},
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx"
        },
        root_dir = util.root_pattern("package.json", "tsconfig.json", ".git")
    }
}

-- -- vue -- --
configs.custom_vue = {
    default_config = {
        cmd = {"vls"},
        filetypes = {"vue"},
        root_dir = util.root_pattern("package.json", ".git"),
        init_options = {
            config = {
                vetur = {
                    format = {
                        defaultFormatter = {
                            html = "prettier",
                            pug = "prettier",
                            css = "prettier",
                            postcss = "prettier",
                            scss = "prettier",
                            less = "prettier",
                            stylus = "stylus-supremacy",
                            js = "prettier",
                            ts = "prettier",
                            sass = "sass-formatter"
                        }
                    }
                }
            }
        }
    }
}

-- -- bash -- --
configs.custom_bash = {
    default_config = {
        cmd = {"bash-language-server", "start"},
        filetypes = {"sh"},
        root_dir = util.path.dirname
    }
}

-- -- clang -- --
configs.custom_clang = {
    default_config = {
        cmd = {"clangd", "--background-index", "--pch-storage=memory", "--clang-tidy"},
        filetypes = {"c", "cpp", "objc", "objcpp"},
        root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        capabilities = {
            textDocument = {
                completion = {
                    editsNearCursor = true
                }
            }
        }
    }
}

local configs = {
    lsp.custom_go,
    lsp.custom_python,
    lsp.custom_typescript,
    lsp.custom_vue,
    lsp.custom_bash,
    lsp.custom_clang,
}

for i, config in pairs(configs) do
    config.setup({
        on_attach = function(client, buffer)
            diagnostic.on_attach(client, buffer)
            completion.on_attach(client, buffer)
        end
    })
end
EOF

" lsp mappings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> J     <cmd>lua vim.lsp.util.show_line_diagnostics()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect
set shortmess+=c

autocmd BufWritePre *.go,*.py                 silent! lua document_format_and_organise_sync()
autocmd BufWritePre *.c,*.vue,*.tsx,*.ts,*.js silent! lua document_format_sync()

" the bar on the left symbols
call sign_define('LspDiagnosticsErrorSign',       {'text': 'ee', 'texthl': 'LspDiagnosticsError'})
call sign_define('LspDiagnosticsWarningSign',     {'text': 'ww', 'texthl': 'LspDiagnosticsWarning'})
call sign_define('LspDiagnosticsInformationSign', {'text': 'ii', 'texthl': 'LspDiagnosticsInformation'})
call sign_define('LspDiagnosticsHintSign',        {'text': 'hh', 'texthl': 'LspDiagnosticsHint'})
