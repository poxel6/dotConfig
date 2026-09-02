-- DONE: should have compile and recompile cmds
-- DONE: does not highlight shit
-- DONE: should populate quickfix
-- DONE: regex for errors are hardcoded for only lua
-- DONE: don't focus the compilation buffer.

-- TODO Create a new filetype (or just a function) that parces the lines and set a mark to the founded fmt.
CM_STATE = {
	lastCmd = "",
	instances = {},
	maxInstances = 4,
	nameSpace = vim.api.nvim_create_namespace("CompileModeNS"),
}

vim.api.nvim_set_hl(0, "CompilationGreen", { fg = "#73d936", bg = nil })
vim.api.nvim_set_hl(0, "CompilationRed", { fg = "#f43841", bg = nil })
vim.api.nvim_set_hl(0, "CompilationERROR", { fg = "#f43841", bg = nil, underline = true })
vim.api.nvim_set_hl(0, "CompilationYellow", { fg = "#ffdd33", bg = nil })
vim.api.nvim_set_hl(0, "CompilationWARNING", { fg = "#cc8c3c", bg = nil, underline = true })
vim.api.nvim_set_hl(0, "CompilationNOTE", { fg = "#96a6c8", bg = nil, underline = true })

local WIN_OPTS = { split = "right" }
local SHELL_PATH = os.getenv("SHELL") or "/bin/zsh"

local Instance = {}
Instance.__index = Instance

local DATE_FMT = "%d/%m/%y %H:%M:%S"
-- local REGEX = "([%w_/]*[%w_]+%.[%w_]+):(%d+):(%d*):?"
local REGEX = "([%w_/]*[%w_]+%.[%w_]+):(%d+):(%d+):"

local function tableToString(t)
	local result = ""
	for _, item in ipairs(t) do
		if type(item) ~= "table" then
			result = result .. item .. " "
		else
			result = result .. "{" .. tableToString(item) .. "} "
		end
	end
	return result
end

function Instance:new(cmd)
	local i = setmetatable({
		buf = vim.api.nvim_create_buf(true, true),
		cmd = cmd,
		running = false,
		marks = {},
		pending = "",
		quickfix = {},
		stdout = vim.uv.new_pipe(true),
		stderr = vim.uv.new_pipe(true),
	}, self)
	assert(i.buf ~= 0)

	local name = string.format("%s *compilation* %s %.2f", cmd, os.date(DATE_FMT), os.clock())
	vim.api.nvim_buf_set_name(i.buf, name)
	vim.api.nvim_set_option_value("swapfile", false, { buf = i.buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = i.buf })
	vim.api.nvim_set_option_value("buflisted", true, { buf = i.buf })

	vim.keymap.set("n", "<CR>", function()
		local row = vim.api.nvim_win_get_cursor(0)[1]
		local s = { row - 1, 0 }
		local e = { row - 1, #vim.api.nvim_get_current_line() }
		local emks = vim.api.nvim_buf_get_extmarks(i.buf, CM_STATE.nameSpace, s, e, { overlap = true, details = true })
		if #emks >= 4 then
			for _, m in ipairs(emks) do
				local found = i.marks[m[1]]
				if found ~= nil then
					i:open_mark(m[1])
					break
				end
			end
		end
	end, { buffer = i.buf, silent = true })

	vim.keymap.set("n", "<C-c>", function()
		i:kill_cmd()
	end, { buffer = i.buf, silent = true })

	table.insert(CM_STATE.instances, i)

	local l = #CM_STATE.instances
	vim.api.nvim_create_autocmd("BufUnload", {
		buffer = i.buf,
		callback = function()
			i:kill_cmd()
		end,
	})
	return i
end

local function get_next_win_id(current)
	local wins = vim.api.nvim_list_wins()
	for i, win_id in ipairs(wins) do
		if win_id == current then
			return wins[(i % #wins) + 1]
		end
	end
end

function Instance:open_mark(key)
	local found = self.marks[key]
	assert(found ~= nil)
	local current = vim.api.nvim_get_current_win()
	local next = get_next_win_id(current)
	local extra = ""
	if next ~= current then
		vim.api.nvim_set_current_win(next)
	else
		extra = extra .. "split | "
	end
	vim.api.nvim_command(extra .. "e " .. found.file)
	vim.fn.cursor(found.row, found.col)
end

local function get_exit_msg(code, signal)
	local r = "Compilation"
	if signal == 11 then
		return r .. " segmentation fault"
	end

	if code ~= 0 then
		r = r .. " exited abnormaly with code " .. code
	else
		r = r .. " finished"
	end
	return r
end

function Instance:on_exit_cmd(code, signal)
	self.running = false
	self.stdout:close()
	self.stderr:close()

	local date = os.date(DATE_FMT)
	local first = string.format("%s at %s", get_exit_msg(code, signal), date)
	local duration = (vim.uv.now() - self.start) / 1000
	local msg = first .. string.format(" duration (%.4f s)", duration)
	local level = (code == 0 or signal ~= 11) and vim.log.levels.INFO or vim.log.levels.ERROR

	vim.schedule(function()
		if vim.api.nvim_buf_is_valid(self.buf) then
			vim.fn.setqflist({}, "r", {
				title = self.cmd,
				items = self.quickfix,
			})

			vim.api.nvim_buf_set_lines(self.buf, -1, -1, false, { "" })
			vim.api.nvim_buf_set_lines(self.buf, -1, -1, false, { msg })
			local lines = vim.api.nvim_buf_line_count(self.buf) - 1
			if code == 0 then
				vim.notify(first, vim.log.levels.INFO)
				self:pattern_hl(msg, lines, "finished", "CompilationGreen")
				self:pattern_hl(msg, lines, "segmentation fault", "CompilationRed")
			else
				vim.notify(first, vim.log.levels.ERROR)
				self:pattern_hl(msg, lines, "exited abnormaly", "CompilationRed")
				if vim.api.nvim_get_current_buf() == self.buf then
					vim.api.nvim_win_set_cursor(0, { lines, 0 })
				end
			end
		end
	end)
end

---@param file string
---@param text string
---@param line number?
---@param col number?
function Instance:popluate_quickfix(file, text, line, col)
	table.insert(self.quickfix, {
		filename = file,
		lnum = line,
		col = col or 0,
		text = text,
	})
end

---@param line string
local function get_hl_level(line)
	line = line:lower()
	if line:match("error") then
		return "CompilationERROR"
	elseif line:match("warning") then
		return "CompilationWARNING"
	elseif line:match("note") then
		return "CompilationNOTE"
	else
		return "CompilationERROR"
	end
end

function Instance:index_hl(line_number, start, finish, hl)
	vim.api.nvim_buf_set_extmark(self.buf, CM_STATE.nameSpace, line_number, start - 1, {
		end_col = finish,
		hl_group = hl,
		priority = 1000,
	})
end

---@param line string
---@param line_number integer
---@param hl string
---@return integer?, integer?
function Instance:pattern_hl(line, line_number, pattern, hl)
	local start, finish = line:find(pattern, 1, true)
	if finish and start and finish - start > 0 then
		vim.api.nvim_buf_set_extmark(self.buf, CM_STATE.nameSpace, line_number, start - 1, {
			end_col = finish,
			hl_group = hl,
			priority = 1000,
		})
	end
	return start, finish
end

---@param line string
---@param line_number integer
function Instance:parse_line(line, line_number)
	local file, row, col = line:match(REGEX)
	if file and row and col then
		self:popluate_quickfix(file, line, tonumber(row), tonumber(col))

		local fstart, fend = self:pattern_hl(line, line_number, file, get_hl_level(line))
		assert(fstart)
		assert(fend)

		self:index_hl(line_number, fend + 2, fend + 1 + #row, "CompilationGreen") -- row
		self:index_hl(line_number, fend + #row + 3, fend + #row + #col + 2, "CompilationGreen") -- col

		self.marks[vim.api.nvim_buf_set_extmark(self.buf, CM_STATE.nameSpace, line_number, 0, { end_col = #line })] = {
			file = file,
			row = tonumber(row),
			col = tonumber(col) or 0,
		}
	end
end

function Instance:put_line(data)
	self.pending = self.pending .. data

	while true do
		local newline = self.pending:find("\n", 1, true)

		if not newline then
			break
		end

		local line = self.pending:sub(1, newline - 1)
		self.pending = self.pending:sub(newline + 1)

		local l = vim.api.nvim_buf_line_count(self.buf)

		vim.api.nvim_buf_set_lines(self.buf, -1, -1, false, { line })

		self:parse_line(line, l)

		if vim.api.nvim_get_current_buf() == self.buf then
			vim.fn.cursor(l, 0)
		end
	end
end

function Instance:run_cmd()
	local msg = "Compilation started at " .. os.date(DATE_FMT)
	vim.api.nvim_buf_set_lines(self.buf, 0, 0, false, { msg })
	vim.api.nvim_buf_set_lines(self.buf, -1, -1, false, { self.cmd, "" })
	self:pattern_hl(msg, 0, "started", "CompilationGreen")
	self.start = vim.uv.now()
	self.lines = 5
	self.handle, self.pid = vim.uv.spawn(SHELL_PATH, {
		args = { "-c", self.cmd },
		cwd = vim.uv.cwd(),
		stdio = { nil, self.stdout, self.stderr },
	}, function(code, signal)
		self:on_exit_cmd(code, signal)
	end)

	assert(self.handle ~= nil)

	self.stdout:read_start(function(err, data)
		assert(not err, err)
		if data then
			vim.schedule(function()
				self:put_line(data)
			end)
		end
	end)

	self.stderr:read_start(function(err, data)
		assert(not err, err)
		if data then
			vim.schedule(function()
				self:put_line(data)
			end)
		end
	end)
end

function Instance:kill_cmd()
	if self.handle ~= nil then
		vim.uv.process_kill(self.handle, "sigint")
	end
end

local function find_buf(buf)
	local wins = vim.api.nvim_list_wins()
	local result = {}
	for _, win in ipairs(wins) do
		local wb = vim.api.nvim_win_get_buf(win)
		if wb == buf then
			table.insert(result, win)
		end
	end
	return result
end

function compile_mode(cmd)
	local current_win = vim.api.nvim_get_current_win()
	local new = Instance:new(cmd)

	if #CM_STATE.instances > CM_STATE.maxInstances then
		for _, instance in ipairs(CM_STATE.instances) do
			if not instance.running then
				local toRemove = CM_STATE.instances[1]
				toRemove:kill_cmd()
				if vim.api.nvim_buf_is_valid(toRemove.buf) then
					vim.api.nvim_buf_delete(toRemove.buf, { force = true })
				end
				table.remove(CM_STATE.instances, 1)
				break
			end
		end
	end

	for i, instance in ipairs(CM_STATE.instances) do
		local win = find_buf(instance.buf)
		if #win > 0 then
			vim.api.nvim_win_set_buf(win[1], new.buf)
			instance:kill_cmd()
			instance = new
			goto exit
		end
	end

	vim.api.nvim_open_win(new.buf, false, WIN_OPTS)

	::exit::
	new:run_cmd()
	vim.api.nvim_set_current_win(current_win)
end

vim.api.nvim_create_user_command("Recompile", function(opt)
	---@diagnostic disable-next-line: unnecessary-if
	if CM_STATE.lastCmd ~= "" then
		compile_mode(CM_STATE.lastCmd)
	elseif #opt.args > 0 then
		local input = opt.args
		compile_mode(input)
		CM_STATE.lastCmd = input
	else
		vim.ui.input({ prompt = "Compile cmd: ", default = CM_STATE.lastCmd }, function(input)
			if not input then
				return
			end
			compile_mode(input)
			CM_STATE.lastCmd = input
		end)
	end
end, { nargs = "*" })

vim.api.nvim_create_user_command("Compile", function(opt)
	---@diagnostic disable-next-line: unnecessary-if
	if #opt.args > 0 then
		local input = opt.args
		compile_mode(input)
		CM_STATE.lastCmd = input
	else
		vim.ui.input({ prompt = "Compile cmd: ", default = CM_STATE.lastCmd }, function(input)
			if not input then
				return
			end
			compile_mode(input)
			CM_STATE.lastCmd = input
		end)
	end
end, { nargs = "*" })
