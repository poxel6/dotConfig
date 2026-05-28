local root_markers = {
  '.emmyrc.json',
  '.emmyrc.lua',
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

---@type vim.lsp.Config
return {
  cmd = { 'emmylua_ls' },
  filetypes = { 'lua' },
  root_markers = root_markers,
  workspace_required = false,
  settings = {
    codeLens = { enable = true },
    hint = { enable = true },
  },
}
