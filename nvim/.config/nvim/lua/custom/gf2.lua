local workspace_root = function()
	local current = vim.api.nvim_buf_get_name(0)
	local root_markers = {
		".git",
		"compile_commands.json",
		"CMakeLists.txt",
		"Cargo.toml",
		"Makefile",
	}

	local root = vim.fs.dirname(vim.fs.find(root_markers, {
		path = current ~= "" and current or vim.fn.getcwd(),
		upward = true,
	})[1] or "")

	return root ~= "" and root or vim.fn.getcwd()
end

local find_executable = function()
	local cwd = workspace_root()
	local current = vim.api.nvim_buf_get_name(0)
	-- local stem = vim.fn.fnamemodify(current, ":t:r")
	local stem = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	local candidates = {
		cwd .. "/" .. stem,
		cwd .. "/build/" .. stem,
		cwd .. "/bin/" .. stem,
		cwd .. "/build/debug/" .. stem,
		cwd .. "/build/Debug/" .. stem,
		cwd .. "/out/" .. stem,
		cwd .. "/target/" .. stem,
		cwd .. "/target/debug/" .. stem,
	}

	for _, candidate in ipairs(candidates) do
		if vim.fn.executable(candidate) == 1 then
			vim.notify("Found" .. candidate, vim.log.levels.INFO)
			return candidate
		end
	end
end

---@return string
local ask_for_executable = function()
	local executable = ""
	vim.ui.input({
		prompt = "Executable: ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	}, function(input)
		executable = input or ""
	end)
	return executable
end

local args = ""
vim.api.nvim_create_user_command("Gf2", function(opts)
	local file = vim.fn.expand("%:p")
	local line = vim.fn.line(".")
	local executable = find_executable() or opts.args[1]
	if not executable or executable == "" then
		executable = ask_for_executable()
	end

	vim.ui.select({ "Launch", "Launch with args", "Change args" }, {
		prompt = "Run gf2:",
	}, function(choice)
		if choice == "Launch with args" then
			if not args or args == "" then
				vim.ui.input({
					prompt = "Args: ",
					default = vim.fn.getcwd() .. "/",
					completion = "file",
				}, function(arguments)
					if arguments and arguments ~= "" then
						args = arguments
					end
				end)
			end
		elseif choice == "Change args" then
			vim.ui.input({
				prompt = "Args: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file",
			}, function(arguments)
				if arguments and arguments ~= "" then
					args = arguments
				end
			end)
		end
		vim.notify(executable)
		vim.system({
			"gf2",
			executable,
			"-ex",
			"r" .. args,
			"-ex",
			"break " .. file .. ":" .. line,
			"-ex",
			"run",
		}, { detach = true })
	end)
end, { nargs = "*" })
