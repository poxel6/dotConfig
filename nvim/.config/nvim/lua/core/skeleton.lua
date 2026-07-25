---@class M
---@field cursor [integer, integer] | nil

M = {}
M.cursor = nil

---@param str string
---@return string
local function pascal_case(str)
	str = str:gsub("[-_](%l)", string.upper)
	return str:sub(1, 1):upper() .. str:sub(2)
end

local subs = {
	["NAME"] = "pox",
	["FILENAME"] = vim.fn.expand("%:r"),
	["CURSOR"] = " ",
	["JAVA_CLASS_NAME"] = pascal_case(vim.fn.expand("%:r")),
}

local patterns = {
	["*.h"] = "skeleton.h",
	["main.c"] = "main.c",
	["*.c"] = "skeleton.c",
	["main.java"] = "main.java",
	["*.java"] = "skeleton.java",
	["*.lua"] = "skeleton.lua",
	["*.md"] = "skeleton.md",
	["LICENSE"] = "LICENSE",
}

---@param line string
---@return string
local replace_patterns = function(line)
	local subs_todo = {}
	for str in string.gmatch(line, "@[%w_]+@") do
		local clean = str:gsub("@", "")
		local val = subs[clean]
		if val then
			subs_todo[clean] = val
		end
	end

	for k, v in pairs(subs_todo) do
		line = string.gsub(line, "@" .. k .. "@", v)
	end

	return line
end

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = vim.tbl_keys(patterns),
	callback = function()
		local filename = vim.fn.expand("%:t")
		local template = patterns[filename]

		if not template then
			for pattern, candidate in pairs(patterns) do
				if vim.fn.match(filename, vim.fn.glob2regpat(pattern)) ~= -1 then
					template = candidate
					break
				end
			end
		end

		local template_path = vim.fn.stdpath("config") .. "/after/template"
		local file = io.open(template_path .. "/" .. template)
		if not file then
			return
		end

		local ls = {}
		for line in file:lines() do
			---@diagnostic disable-next-line: need-check-nil
			local find_cursor = line:find("@CURSOR@", 1, true)
			if find_cursor then
				local curr = { #ls + 1, find_cursor - 1 }
				M.cursor = curr
			end

			---@cast line string
			table.insert(ls, replace_patterns(line))
		end
		vim.api.nvim_buf_set_lines(0, 0, -1, false, ls)
		---@diagnostic disable-next-line: unnecessary-if
		if M.cursor then
			vim.api.nvim_win_set_cursor(0, M.cursor)
		end
	end,
})
return M
