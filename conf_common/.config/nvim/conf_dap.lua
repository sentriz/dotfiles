local dap = require("dap")

local default_port = 9901

dap.adapters.go = function(cb, _config)
	return cb({
		type = "server",
		port = vim.fn.input("port: ", default_port),
		host = "localhost",
	})
end

dap.configurations.go = {
	{
		-- dlv debug --headless --listen=:9901 --accept-multiclient --api-version=2 main.go
		name = "delve remote attach",
		type = "go",
		request = "attach",

		mode = "remote",
		substitutePath = { { from = "${workspaceFolder}", to = "/go/src/app" } },
	},

	{
		-- dlv dap --listen :9901
		name = "delve local launch",
		type = "go",
		request = "launch",

		program = "${file}",
	},
	{
		-- dlv dap --listen :9901
		name = "delve local test",
		type = "go",
		request = "launch",

		mode = "test",
		program = "${file}",
	},
	{
		-- dlv dap --listen :9901
		name = "delve local test package",
		type = "go",
		request = "launch",

		mode = "test",
		program = "./${relativeFileDirname}",
	},
}
