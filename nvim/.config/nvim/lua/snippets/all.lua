
---@diagnostic disable: undefined-field, unresolved-require
local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local day_fmt = "{}{}"
local day_inodes = { f(function() return os.date("%F") end), i(0) }
local day = {
  s("day", fmt(day_fmt, day_inodes, {})),
}

ls.add_snippets("all", day)	
