vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-J>", ":co '<<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<C-K>", ":co '>-1<CR>gv=gv", { silent = true })

vim.keymap.set("n", "<leader>r", "<CMD>make<CR>")
vim.keymap.set("n", "<F5>", "<CMD>update<CR><CMD>restart<CR>")
vim.keymap.set("n", "-", "<CMD>Ex<CR>")
vim.keymap.set("n", "<leader><leader>", "<CMD>e #<CR>")

vim.keymap.set({ "x", "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "x", "v", "n" }, "gro", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>sf", "<CMD>Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>sh", "<CMD>Telescope help_tags<CR>", { silent = true })
vim.keymap.set("n", "<leader>sl", "<CMD>Telescope live_grep<CR>", { silent = true })
vim.keymap.set(
	"n", "<leader>st",
	"<CMD>lua require('telescope.builtin').colorscheme({enable_preview = true, ignore_builtins = true, preview = false})<CR>",
	{ silent = true }
)

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
