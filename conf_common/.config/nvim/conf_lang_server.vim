" bash          npm install -g bash-language-server
" c             <package manager> install clang
" dockerfile    npm install -g dockerfile-language-server-nodejs
" go            go get -u golang.org/x/tools/gopls@latest
" python        pip install --user pyls-black
" python        pip install --user python-language-server[flake8]
" js, ts        npm install -g typescript typescript-language-server
" vue           npm install -g typescript vls

lua <<EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
    }
)

local lsp        = require "lspconfig"
local configs    = require "lspconfig/configs"
local util       = require "lspconfig/util"

local sync_timeout = 150

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

-- -- docker -- --
configs.custom_docker = {
    default_config = {
        cmd = {"docker-langserver", "--stdio"},
        filetypes = {"dockerfile"},
        root_dir = util.root_pattern("Dockerfile")
    }
}

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
            },
            capabilities = {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true
                        }
                    }
                }
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
                    validation = {
                        templateProps = true,
                    },
                    completion = {
                        tagCasing = "initial",
                    },
                    format = {
                        defaultFormatter = {
                            html = "prettier",
                            pug = "prettier",
                            css = "none",
                            postcss = "prettier",
                            scss = "prettier",
                            less = "prettier",
                            stylus = "stylus-supremacy",
                            js = "prettier",
                            ts = "prettier",
                            sass = "sass-formatter"
                        }
                    },
                    experimental = {
                        templateInterpolationService = true,
                    }
                }
            }
        }
    }
}

-- -- dart -- --
configs.custom_dart = {
    default_config = {
        cmd = {"dart", "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp"},
        filetypes = {"dart"},
        root_dir = util.root_pattern("pubspec.yaml", ".git"),
        init_options = {
            closingLabels = "true",
            flutterOutline = "false",
            onlyAnalyzeProjectsWithOpenFiles = "false",
            outline = "true",
            suggestFromUnimportedLibraries = "true"
      },
    }
}

-- -- java -- --
configs.custom_java = {
    default_config = {
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.level=ALL",
            "-noverify",
            "-Xmx1G",
            "-jar", "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.5.800.v20200727-1323.jar",
            "-data", "workspace",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED"
        },
        filetypes = {"java"},
        root_dir = util.root_pattern(".git"),
        init_options = {
            workspace = "workspace",
        }
    }
}

lsp.custom_bash.setup({})
lsp.custom_clang.setup({})
lsp.custom_docker.setup({})
lsp.custom_go.setup({})
lsp.custom_python.setup({})
lsp.custom_typescript.setup({})
lsp.custom_vue.setup({})
lsp.custom_dart.setup({})
lsp.custom_java.setup({})
EOF

" lsp mappings
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> J     <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> gn    <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<cr>
vnoremap <silent> ga    <cmd>'<,'>lua vim.lsp.buf.range_code_action()<cr>

set omnifunc=v:lua.vim.lsp.omnifunc
set completeopt=menuone,noinsert,noselect
set shortmess+=c

autocmd Filetype c               autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype dockerfile      autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype javascript      autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype typescript      autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype typescriptreact autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype vue             autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype dart            autocmd BufWritePre * silent! lua document_format_sync()
autocmd Filetype go              autocmd BufWritePre * silent! lua document_format_and_organise_sync()
autocmd Filetype python          autocmd BufWritePre * silent! lua document_format_and_organise_sync()

sign define LspDiagnosticsSignError       text=ee texthl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning     text=ww texthl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=ii texthl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint        text=hh texthl=LspDiagnosticsSignHint
