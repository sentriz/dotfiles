-- prettier          npm install -g prettier
-- prettier template npm install -g prettier prettier-plugin-go-template
-- prettier svelte   npm install -g prettier prettier-plugin-svelte svelte
-- goimports         go get -u golang.org/x/tools/cmd/goimports
-- clang-format      <package manager> install clang
-- black             pip install --user black
-- luafmt            npm install -g lua-fmt

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

function formatter_shfmt()
    return {
        exe = "shfmt",
        args = {"-i", 4, "-bn", "-kp", "-"},
        stdin = true
    }
end

function formatter_luafmt()
    return {
        exe = "luafmt",
        args = {"--indent-count", 4, "--stdin"},
        stdin = true
    }
end

formatter.setup(
    {
        logging = false,
        filetype = {
            ["javascript"] = {formatter_prettier},
            ["typescript"] = {formatter_prettier},
            ["typescriptreact"] = {formatter_prettier},
            ["vue"] = {formatter_prettier},
            ["yaml"] = {formatter_prettier},
            ["yaml.docker-compose"] = {formatter_prettier},
            ["html"] = {formatter_prettier},
            ["css"] = {formatter_prettier},
            ["json"] = {formatter_prettier},
            ["template"] = {formatter_prettier},
            ["svelte"] = {formatter_prettier},
            ["go"] = {formatter_goimports},
            ["c"] = {formatter_clang},
            ["cpp"] = {formatter_clang},
            ["python"] = {formatter_black},
            ["sh"] = {formatter_shfmt},
            ["lua"] = {formatter_luafmt}
        }
    }
)
