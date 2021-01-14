" pretter       npm install -g prettier
" goimports     go get -u golang.org/x/tools/cmd/goimports
" clang-format  <package manager> install clang
" black         pip install --user black

lua <<EOF
local formatter = require "formatter"

function formatter_prettier()
    return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

function formatter_goimports()
    return {
        exe = "goimports",
        args = {"-srcdir", vim.api.nvim_buf_get_name(0)},
        stdin = true
    }
end

function formatter_clang()
    return {
        exe = "clang-format",
        args = {"--assume-filename", vim.api.nvim_buf_get_name(0), "-"},
        stdin = true
    }
end

function formatter_black()
    return {
        exe = "black",
        args = {"--quiet", "-"},
        stdin = true
    }
end


formatter.setup({
    logging = false,
    filetype = {
        ["javascript"]          = { formatter_prettier },
        ["typescript"]          = { formatter_prettier },
        ["typescriptreact"]     = { formatter_prettier },
        ["vue"]                 = { formatter_prettier },
        ["yaml"]                = { formatter_prettier },
        ["yaml.docker-compose"] = { formatter_prettier },
        ["html"]                = { formatter_prettier },
        ["css"]                 = { formatter_prettier },
        ["json"]                = { formatter_prettier },
        ["go"]                  = { formatter_goimports },
        ["c"]                   = { formatter_clang },
        ["cpp"]                 = { formatter_clang },
        ["python"]              = { formatter_black },
    }
})
EOF

autocmd Filetype javascript          autocmd BufWritePost * FormatWrite
autocmd Filetype typescript          autocmd BufWritePost * FormatWrite
autocmd Filetype typescriptreact     autocmd BufWritePost * FormatWrite
autocmd Filetype vue                 autocmd BufWritePost * FormatWrite
autocmd Filetype yaml                autocmd BufWritePost * FormatWrite
autocmd Filetype yaml.docker-compose autocmd BufWritePost * FormatWrite
autocmd Filetype html                autocmd BufWritePost * FormatWrite
autocmd Filetype css                 autocmd BufWritePost * FormatWrite
autocmd Filetype json                autocmd BufWritePost * FormatWrite
autocmd Filetype go                  autocmd BufWritePost * FormatWrite
autocmd Filetype c                   autocmd BufWritePost * FormatWrite
autocmd Filetype cpp                 autocmd BufWritePost * FormatWrite
autocmd Filetype python              autocmd BufWritePost * FormatWrite
