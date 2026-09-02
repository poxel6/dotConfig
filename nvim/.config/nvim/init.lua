vim.loader.enable()

require("core.option")
require("core.keymap")
require("core.lazy")
require("core.autocmd")
require("core.lsp")
require("core.fold")
require("core.colors")

require("custom.skeleton")
require("custom.autorun")
require("custom.tabline")
require("custom.ui2")

vim.cmd("colorscheme ayu")

require("custom.compile")
