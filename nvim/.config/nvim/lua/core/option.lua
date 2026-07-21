vim.loader.enable()

vim.g.mapleader = " "

vim.opt.inccommand = "split"
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.signcolumn = "yes:1"

vim.opt.winborder = "rounded"
vim.opt.pumborder = "rounded"
vim.opt.pumblend = 0
vim.opt.pumheight = 8
vim.opt.pumwidth = 50
vim.opt.pummaxwidth = 55

vim.opt.wrap = false
vim.opt.swapfile = false

vim.opt.formatoptions:remove("o")
vim.opt.formatoptions:append("q")

vim.g.netrw_banner = false
