-- bash        npm install -g bash-language-server
-- c           <package manager> install clang
-- dockerfile  npm install -g dockerfile-language-server-nodejs
-- go          go get -u golang.org/x/tools/gopls@latest
-- python      npm install -g pyright
-- js, ts      npm install -g typescript typescript-language-server
-- vue         npm install -g typescript vls
-- svelte      npm install -g svelte svelte-language-server
-- tailwind    latest vsix file https://github.com/tailwindlabs/tailwindcss-intellisense
-- sql         go get -u github.com/lighttiger2505/sqls

vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        signs = true,
        update_in_insert = false
    }
)

local lsp = require "lspconfig"
local configs = require "lspconfig/configs"
local util = require "lspconfig/util"
local illuminate = require "illuminate"
local sqls = require "sqls"

-- -- bash
configs.custom_bash = {
    default_config = {
        cmd = {"bash-language-server", "start"},
        filetypes = {"sh"},
        root_dir = util.path.dirname
    }
}

-- -- clang
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

-- -- docker
configs.custom_docker = {
    default_config = {
        cmd = {"docker-langserver", "--stdio"},
        filetypes = {"dockerfile"},
        root_dir = util.root_pattern("Dockerfile")
    }
}

-- -- go
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
                staticcheck = true,
                analyses = {
                    unreachable = true,
                    unusedparams = true
                }
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

-- -- python
configs.custom_python = {
    default_config = {
        cmd = {"pyright-langserver", "--stdio"},
        filetypes = {"python"},
        root_dir = util.root_pattern("requirements.txt", "pyproject.toml", "Pipfile", ".git"),
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true
                }
            }
        }
    }
}

-- -- typescript
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

-- -- vue
configs.custom_vue = {
    default_config = {
        cmd = {"vls"},
        filetypes = {"vue"},
        root_dir = util.root_pattern("package.json", ".git"),
        init_options = {
            config = {
                vetur = {
                    validation = {
                        templateProps = true
                    },
                    completion = {
                        tagCasing = "initial"
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
                        templateInterpolationService = true
                    }
                }
            }
        }
    }
}

-- -- dart
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
        }
    }
}

-- -- java
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
            "-jar",
            "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.5.800.v20200727-1323.jar",
            "-data",
            "workspace",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED"
        },
        filetypes = {"java"},
        root_dir = util.root_pattern(".git"),
        init_options = {
            workspace = "workspace"
        }
    }
}

-- -- svelte
configs.custom_svelte = {
    default_config = {
        cmd = {"svelteserver", "--stdio"},
        filetypes = {"svelte"},
        root_dir = util.root_pattern("package.json", ".git")
    }
}

-- -- tailwind
configs.custom_tailwind = {
    default_config = {
        cmd = {"node", vim.env.DOTS_PROJECTS_DIR .. "/tailwind-lsp/extension/dist/server/index.js", "--stdio"},
        filetypes = {"html"},
        root_dir = util.root_pattern("package.json", ".git")
    }
}

-- -- sql
configs.custom_sql = {
    default_config = {
        cmd = {"sqls", "-config", vim.env.XDG_CONFIG_HOME .. "/sqls/config.yml"},
        filetypes = {"sql"},
        root_dir = util.path.dirname
    }
}

local args = {
    on_attach = function(client)
        illuminate.on_attach(client)
    end
}

local sqls_args = {
    on_attach = function(client)
        client.resolved_capabilities.execute_command = true
        illuminate.on_attach(client)
        sqls.setup {}
    end
}

lsp.custom_bash.setup(args)
lsp.custom_clang.setup(args)
lsp.custom_docker.setup(args)
lsp.custom_go.setup(args)
lsp.custom_python.setup(args)
lsp.custom_typescript.setup(args)
lsp.custom_vue.setup(args)
lsp.custom_dart.setup(args)
lsp.custom_java.setup(args)
lsp.custom_svelte.setup(args)
lsp.custom_tailwind.setup(args)
lsp.custom_sql.setup(sqls_args)
