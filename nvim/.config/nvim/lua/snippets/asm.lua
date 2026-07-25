---@diagnostic disable: undefined-field, unresolved-require
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local sys1_fmt = [[
	mov		rax, {}
	mov		rdi, {}
	syscall
	{}
]]
local sys1_inodes = { i(1, "sys"), i(2, "first-arg"), i(0) }
local sys1 = {
	s("sys1", fmt(sys1_fmt, sys1_inodes, {})),
}

local sys2_fmt = [[
	mov		rax, {}
	mov		rdi, {}
	mov		rsi, {}
	syscall
	{}
]]
local sys2_inodes = { i(1, "sys"), i(2, "first-arg"), i(3, "second-arg"), i(0) }
local sys2 = {
	s("sys2", fmt(sys2_fmt, sys2_inodes, {})),
}

local sys3_fmt = [[
	mov		rax, {}
	mov		rdi, {}
	mov		rsi, {}
	mov		rdx, {}
	syscall
	{}
]]
local sys3_inodes = { i(1, "sys"), i(2, "first-arg"), i(3, "second-arg"), i(4, "third-arg"), i(0) }
local sys3 = {
	s("sys3", fmt(sys3_fmt, sys3_inodes, {})),
}

local main_fmt = [[
format ELF64 executable
segment readable executable
entry main

main:
	{}

segment readable writeable

]]
local main_inodes = { i(0) }
local main = {
	s("main", fmt(main_fmt, main_inodes, {})),
}

ls.add_snippets("asm", sys1)
ls.add_snippets("asm", sys2)
ls.add_snippets("asm", sys3)

ls.add_snippets("asm", main)
