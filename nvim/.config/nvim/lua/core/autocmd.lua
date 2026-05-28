vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function ()
		vim.highlight.on_yank({ higroup = 'Visual' })
	end
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "When client attaches to the server",
	callback = function ()
		local clients = vim.lsp.get_clients()
		for _, v in ipairs(clients) do
			vim.notify(string.format("Attached to %s", v.name))
		end
	end
})

vim.api.nvim_create_user_command("Chmod", '!chmod +x %', {})

vim.api.nvim_create_autocmd({ "ColorScheme", "BufEnter" }, {
	desc = "When ColorScheme is changed, source my color patches.",
	callback = function ()
		require("core.colors").setup()
	end
})

local path = vim.fn.stdpath("config") .. "/after/template"
for skeleton in vim.fs.dir(path, {}) do
	local list = vim.split(skeleton, '.', { plain = true })
	local ext = list[#list]
	local pattern = "{{CURSOR}}"
	vim.api.nvim_create_autocmd("BufNewFile", {
		pattern = "*." .. ext,
		desc = "template for '" .. ext .. "' files.",
		callback = function ()
			vim.api.nvim_buf_set_lines(0, 0, 0, true, {})
			vim.cmd("0r " .. path .. "/skeleton." .. ext)
			for lnum = 1, vim.api.nvim_buf_line_count(0) do
				local line = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
				local col = line:find(pattern, 1, true)
				if col then -------------------- row ----- col ---- end_row  end_col - offset __ content
					vim.api.nvim_buf_set_text(0, lnum - 1, col - 1, lnum - 1, col - 1 + #pattern, {})
					vim.api.nvim_win_set_cursor(0, { lnum, col - 1 })
					return
				end
			end
		end
	})
end
