local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local rep = require('luasnip.extras').rep
local fmt = require("luasnip.extras.fmt").fmt

local biome_ignore_fmt = [[// biome-ignore-start lint: test

{}

// biome-ignore-end lint: test]]
local biome_ignore_inodes = { i(0) }
local biome_ignore = {
  s("big", fmt(biome_ignore_fmt, biome_ignore_inodes, {})),
}

local arr_fmt = "const arr = [692, 101, 491, 759, 473, 311, 217, 809];\n{}"
local arr_inodes = { i(0) }
local arr = {
  s("arr", fmt(arr_fmt, arr_inodes, {})),
}

local for_fmt = "for (let {} = 0; {} < {}.length; {}++) {{\n\t{}\n}}"
local for_inodes = { i(1), rep(1), i(2), rep(1), i(0) }
local for_snip = {
  s("for", fmt(for_fmt, for_inodes, {})),
}

local log_fmt = "console.log(`{}: ${{{}}}`);\n{}"
local log_inodes = { i(1),rep(1),i(0) }
local log = {
  s("log", fmt(log_fmt, log_inodes, {})),
}

ls.add_snippets("typescript", log)
ls.add_snippets("typescript", for_snip)
ls.add_snippets("typescript", arr)
ls.add_snippets("typescript", biome_ignore)
