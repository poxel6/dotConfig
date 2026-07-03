local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local comp_fmt = [[export default function {}() {{
	return (
		{}
	);
}}]]
local comp_inodes = { i(1), i(0) }
local comp = { s("comp", fmt(comp_fmt, comp_inodes, {})) }

ls.add_snippets("typescriptreact", comp)
ls.add_snippets("javascriptreact", comp)
