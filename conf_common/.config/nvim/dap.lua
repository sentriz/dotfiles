local dap = require("dap")

local go = function(name, request, mode, conf)
	local base = {
		name = name,
		type = "go",
		request = request,
		mode = mode,

		host = "localhost",
		port = function()
			return vim.fn.input("port: ", "9901")
		end,
	}
	for k, v in pairs(conf) do
		base[k] = v
	end
	return base
end

dap.adapters.go = function(cb, config)
	return cb({ type = "server", port = config.port, host = config.host })
end

dap.configurations.go = {
	-- dlv debug --headless --listen=:9901 --accept-multiclient --api-version=2 main.go
	go("delve remote attach", "attach", "remote", {
		substitutePath = { { from = "${workspaceFolder}", to = "/go/src/app" } },
	}),

	-- dlv dap --listen :9901
	go("delve local debug", "launch", "debug", {
		program = "${file}",
		args = function()
			return vim.split(vim.fn.input("args: "), " ")
		end,
	}),

	-- dlv dap --listen :9901
	go("delve local test", "launch", "test", {
		program = "${file}",
	}),

	-- dlv dap --listen :9901
	go("delve local test package", "launch", "test", {
		program = "./${relativeFileDirname}",
	}),
}
