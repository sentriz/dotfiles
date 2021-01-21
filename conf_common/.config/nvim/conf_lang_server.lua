-- bash        npm install -g bash-language-server
-- c           <package manager> install clang
-- dockerfile  npm install -g dockerfile-language-server-nodejs
-- go          go get -u golang.org/x/tools/gopls@latest
-- python      npm install -g pyright
-- js, ts      npm install -g typescript typescript-language-server
-- vue         npm install -g typescript vls

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
local completion = require "completion"

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
        }
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

local args = {
    on_attach = completion.on_attach
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