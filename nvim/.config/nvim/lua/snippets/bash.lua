local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node

local shebang_fmt = "#!/usr/bin/env {}"
local shebang_inodes = { c(1, {
	t("bash"),
	i(0),
})
}
local shebang = {
	s("#", fmt(shebang_fmt, shebang_inodes, {})),
}

ls.add_snippets("bash", shebang)
ls.add_snippets("sh", shebang)
ls.add_snippets("", shebang)
