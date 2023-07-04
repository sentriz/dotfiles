#!/usr/bin/wpexec

-- # selene: allow(undefined_variable, unscoped_variables)
-- # vim: ft=lua

-- usage:
--     $ wp-update sink/source default=<name>
--     $ wp-update sink/source volume=0.50
--     $ wp-update sink/source volume=+0.05
--     $ wp-update sink/source volume=-0.05
--     $ wp-update sink/source mute=yes
--     $ wp-update sink/source mute=no
--     $ wp-update sink/source mute=toggle

local media_class_from_args = function(args)
	return args.sink and "Audio/Sink" or "Audio/Source"
end

local parse_bool = function(str)
	local vs = { ["yes"] = true, ["no"] = false }
	return vs[str]
end

local clamp = function(n, min, max)
	n = math.max(min, n)
	n = math.min(max, n)
	return n
end

local run = function(default_nodes, mixer, args)
	if args.default then
		default_nodes:call("set-default-configured-node-name", media_class_from_args(args), args.default)
		return
	end

	if args.volume then
		local id = default_nodes:call("get-default-node", media_class_from_args(args))
		if string.find(args.volume, "+") or string.find(args.volume, "-") then
			local data = mixer:call("get-volume", id)
			mixer:call("set-volume", id, { volume = clamp(data.volume + tonumber(args.volume), 0.0, 1.0) })
		else
			mixer:call("set-volume", id, { volume = tonumber(args.volume) })
		end
		return
	end

	if args.mute then
		local id = default_nodes:call("get-default-node", media_class_from_args(args))
		if parse_bool(args.mute) ~= nil then
			mixer:call("set-volume", id, { mute = parse_bool(args.mute) })
		else
			local data = mixer:call("get-volume", id)
			mixer:call("set-volume", id, { mute = not data.mute })
		end
		return
	end
end

local args = (...)
Core.require_api("default-nodes", "mixer", function(default_nodes, mixer)
	mixer.scale = "cubic"
	run(default_nodes, mixer, args)
	Core.quit()
end)
