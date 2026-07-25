local o = vim.opt_local

o.tabstop = 8
o.shiftwidth = 8

vim.cmd("set syntax=fasm")
local s = vim.fn.expand("%:r")
vim.cmd("set makeprg=fasm\\ %\\ " .. s .. "\\ &&\\ ./" .. s)
