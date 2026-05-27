local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local details_fmt = [[<details>
<summary>
{}
</summary>
{}
</details>]]

local details_inodes = { i(1), i(0) }
local details = {
	s("det", fmt(details_fmt, details_inodes, {})),
}

ls.add_snippets("markdown", details)
