local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require('luasnip.extras').rep

local snip_fmt = [[
local {}_fmt = {}
local {}_inodes = {{ {} }}
local {} = {{
  s("{}", fmt({}_fmt, {}_inodes, {{}})),
}}

ls.add_snippets("{}", {}){}]]

local snip_inodes = {
	i(1),
	i(2, "fmt"),
	rep(1),
	i(3, "inodes"),
	rep(1),
	rep(1),
	rep(1),
	rep(1),
	i(4, "lang"),
	rep(1),
	i(0),
}

local snip = {
	s("snip", fmt(snip_fmt, snip_inodes, {})),
}

ls.add_snippets("lua", snip)
