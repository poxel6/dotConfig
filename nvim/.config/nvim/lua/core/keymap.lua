vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-J>", ":co '<<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-K>", ":co '>-1<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<leader>r", "<CMD>make<CR>")
vim.keymap.set("n", "<C-q>", "<CMD>:cwindow<CR>")
vim.keymap.set("n", "<C-S-q>", "<CMD>:cclose<CR>")
vim.keymap.set("n", "<F5>", "<CMD>update<CR><CMD>restart<CR>")
vim.keymap.set("n", "-", "<CMD>Ex<CR>")
vim.keymap.set("n", "<leader><leader>", "<CMD>e #<CR>")

vim.keymap.set({ "x", "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "x", "v", "n" }, "gro", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>l", "<CMD>%lua<CR>")
vim.keymap.set("v", "<leader>l", "<CMD>'<,'>lua<CR>gv")
vim.keymap.set("n", "<leader>i", function ()
	vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines or false })
end)

vim.keymap.set("n", "<leader>m", function ()
	vim.schedule(function ()
		vim.cmd "silent! make"
		vim.cmd "cwindow"
		print "built"
	end)
end)

vim.keymap.set("n", "<leader>M", function ()
	vim.schedule(function ()
		vim.cmd "silent! make run"
		vim.cmd "cwindow"
		print "built"
	end)
end)

vim.keymap.set({ "i", "s" }, "<C-e>", function ()
	return require("luasnip").expandable() and '<CMD>lua require("luasnip").expand()<CR>' or "<C-e>"
end, { expr = true, silent = true }
)

vim.keymap.set({ "i", "s" }, "<Tab>", function ()
	if require("luasnip").jumpable(1) then
		return '<CMD>lua require("luasnip").jump(1)<CR>'
	else
		return '<Tab>'
	end
end, { expr = true, silent = true }
)

vim.keymap.set({ "i", "s" }, "<S-Tab>", function ()
	if require("luasnip").jumpable(-1) then
		return '<CMD>lua require("luasnip").jump(-1)<CR>'
	else
		return '<S-Tab>'
	end
end, { expr = true, silent = true }
)
vim.keymap.set({ "i", "s" }, "<C-n>", function ()
	if require("luasnip").choice_active() then
		return '<CMD>lua require("luasnip").change_choice(1)<CR>'
	else
		return '<C-n>'
	end
end, { expr = true, silent = true }
)
vim.keymap.set({ "i", "s" }, "<C-p>", function ()
	if require("luasnip").choice_active() then
		return '<CMD>lua require("luasnip").change_choice(-1)<CR>'
	else
		return '<C-p>'
	end
end, { expr = true, silent = true }
)
