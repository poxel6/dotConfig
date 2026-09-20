---@param path string
---@return string?
local function odin_root(path)
	local root = os.getenv("ODIN_ROOT")
	if root == nil or root == "" then
		if vim.fn.executable("odin") == 0 then
			return nil
		end

		local result = vim.system({ "odin", "root" }, { text = true }):wait()
		if result.code ~= 0 or not result.stdout then
			return nil
		end

		root = vim.trim(result.stdout)
	end

	root = vim.fs.normalize(root)
	path = vim.fs.normalize(path)

	for _, lib in ipairs({ "base", "core", "vendor" }) do
		if vim.fs.relpath(vim.fs.joinpath(root, lib), path) ~= nil then
			for _, client in ipairs(vim.lsp.get_clients({ name = "ols" })) do
				if client.config.root_dir then
					return client.config.root_dir
				end
			end
			return nil
		end
	end

	return nil
end

---@type vim.lsp.Config
return {
	cmd = { "ols" },
	filetypes = { "odin" },

	root_dir = function(bufnr, on_dir)
		local path = vim.api.nvim_buf_get_name(bufnr)

		if odin_root(path) then
			on_dir(odin_root(path))
			return
		end

		on_dir(vim.fs.root(bufnr, { "ols.json", ".git" }))
	end,
}
