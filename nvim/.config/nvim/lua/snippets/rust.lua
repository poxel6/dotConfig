local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local tmod_fmt = [[
#[cfg(test)]
mod tests {{
    use super::*;

    #[test]
    fn {}() {{
        assert_eq!();
    }}

}}
]]
local tmod_inodes = { i(0) }
local tmod = {
	s("tmod", fmt(tmod_fmt, tmod_inodes, {})),
}

local test_fmt = [[
#[test]
fn test_{}() {{
    assert_eq!({});
}}
]]
local test_inodes = { i(1), i(0) }
local test = {
	s("test", fmt(test_fmt, test_inodes, {})),
}

local from_fmt = [[pub fn from({}) -> Self {{
	{}
}}]]
local from_inodes = { i(1), i(0) }
local from = {
  s("from", fmt(from_fmt, from_inodes, {})),
}
local new_fmt = [[pub fn new({}) -> Self {{
	{}
}}]]

local new_inodes = { i(1), i(0) }
local new = {
  s("new", fmt(new_fmt, new_inodes, {})),
}
local dynerr_fmt = "Result<(), Box<dyn error::Error>>{}"
local dynerr_inodes = { i(0) }
local dynerr = {
  s("dynerr", fmt(dynerr_fmt, dynerr_inodes, {})),
}

ls.add_snippets("rust", dynerr)
ls.add_snippets("rust", new)
ls.add_snippets("rust", from)
ls.add_snippets("rust", test)
ls.add_snippets("rust", tmod)
