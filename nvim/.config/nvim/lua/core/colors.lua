M = {}
-- @param table<Integer, String>
local groups = {
	"Normal", "NormalBorder", "NormalFloat", "FloatBorder", "FloatShadow", "FloatShadowThrough", "TabLineSel",
	"TabLineFill", "StatusLine", "StatusLineNC", "StatusLinePart", "StatusLinePartNC", "EndOfBuffer", "NormalNC",
	"Pmenu", "PmenuBorder", "PmenuSbar", "PmenuKind", "BlinkCmpMenu", "BlinkCmpKind", "BlinkCmpMenuBorder",
	"BlinkCmpLabel", "BlinkCmpLabelDescription", "BlinkCmpLabelDetail", "BlinkCmpScrollBarThumb",
	"BlinkCmpScrollBarGutter", "BlinkCmpDocBorder", "BlinkCmpDocSeparator"
}

M.setup = function ()
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
end

return M
