local o = vim.opt_local

o.tabstop = 8
o.shiftwidth = 8

vim.cmd("set syntax=fasm")
vim.cmd("set makeprg=fasm\\ %\\ main\\ &&\\ ./main")
