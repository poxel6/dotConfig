---@diagnostic disable: undefined-field
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual" })
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	desc = "When client attaches to the server",
-- 	callback = function()
-- 		local clients = vim.lsp.get_clients()
-- 		for _, v in ipairs(clients) do
-- 			vim.notify(string.format("Attached to %s", v.name))
-- 		end
-- 	end,
-- })
--
vim.api.nvim_create_user_command("Chmod", "!chmod +x %", {})

vim.api.nvim_create_autocmd({ "ColorScheme", "BufRead" }, {
	desc = "When ColorScheme is changed, source my color patches.",
	callback = function()
		require("core.colors").setup()
	end,
})

---@return string|nil
local get_matching_c_file = function()
	local current = vim.fn.expand("%:t:r")

	local cmd = string.format(
		"find . -mindepth 1 -maxdepth 2 -type f -regex './\\(include\\|src\\)/%s\\.\\(h\\|hpp\\|c\\|cpp\\)'",
		current
	)

	local files = vim.fn.systemlist(cmd)

	-- Remove the current file from the results
	local current_file = vim.fn.expand("%:p")
	local other_file

	for _, file in ipairs(files) do
		local absolute = vim.fn.fnamemodify(file, ":p")
		if absolute ~= current_file then
			other_file = file
			break
		end
	end

	return other_file
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "h", "hpp" },
	callback = function(args)
		vim.keymap.set("n", "<leader>h", function()
			local other_file = get_matching_c_file()
			if other_file then
				vim.cmd("e " .. vim.fn.fnameescape(other_file))
			end
		end, { buffer = args.buf })

		vim.keymap.set("n", "<leader>H", function()
			local other_file = get_matching_c_file()
			if other_file then
				vim.cmd("vs " .. vim.fn.fnameescape(other_file))
			end
		end, { buffer = args.buf })
	end,
})
