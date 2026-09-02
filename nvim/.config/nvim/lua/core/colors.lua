M = {}
---@type string[]
local groups = {
	"Normal",
	"NormalBorder",
	"NormalFloat",
	"NormalNC",
	"FloatBorder",
	"FloatShadow",
	"FloatShadowThrough",
	"SignColumn",
	"TabLineSel",
	"TabLineFill",
	"StatusLine",
	"StatusLineNC",
	"StatusLinePart",
	"StatusLinePartNC",
	"EndOfBuffer",
	"WinSeparator",
	"Pmenu",
	"PmenuBorder",
	"PmenuSbar",
	"PmenuKind",
	"BlinkCmpMenu",
	"BlinkCmpKind",
	"BlinkCmpMenuBorder",
	"BlinkCmpLabel",
	"BlinkCmpLabelDescription",
	"BlinkCmpLabelDetail",
	"BlinkCmpScrollBarThumb",
	"BlinkCmpScrollBarGutter",
	"BlinkCmpDocBorder",
	"BlinkCmpDocSeparator",
}

M.setup = function()
	for _, name in ipairs(groups) do
		vim.api.nvim_set_hl(0, name, { bg = "NONE" })
	end

	vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", fg = "#5c6370" })
	if vim.opt.relativenumber then -- doesn't work btw
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#c678dd", bold = true })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#5c6370" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#5c6370" })
	else
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6370" })
	end

	vim.api.nvim_set_hl(0, "LspInlayHint", { link = "comment" })

	for _, mode in pairs({
		"normal",
		"insert",
		"visual",
		"replace",
		"command",
		"inactive",
	}) do
		for _, section in pairs({ "b", "c", "x", "y" }) do
			local hl = "lualine_" .. section .. "_" .. mode
			vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
		end
	end
end

return M
