-- A function to generate the custom tabline string
function my_tabline()

  local result = ""
  local current_tab = vim.fn.tabpagenr()

  for tabnr = 1, vim.fn.tabpagenr('$') do

    result = result .. "%" .. tabnr .. "T"
    local winnr = vim.fn.tabpagewinnr(tabnr)

    local bufnr = vim.fn.tabpagebuflist(tabnr)[winnr]
    local bufname = vim.fn.bufname(bufnr)
	local basename = vim.fs.basename(bufname)

	local devcons = require("nvim-web-devicons")
	local groupname = "TabIconLineName_"
	local group = groupname .. bufnr

	local icon, color = devcons.get_icon_color(bufname)
	if basename == "NeogitStatus" then
		basename = "NeoGit"
		icon, color = devcons.get_icon_color("git")
	end

	vim.api.nvim_set_hl(0, groupname .. bufnr, { fg = color })

    local label = (bufname == "" and "[Untitled]" or basename)
	result = result .. "%#" .. group .. "#" .. (icon or "") .. "%*"

    -- Add the label to the tabline
	if tabnr == current_tab then
		result = result .. " " .. "%#" .. "TabLineSel" .. "#" .. label .. "   "
	else
		result = result .. " " .. label .. "   "
	end
  end
  return result
end

-- Set Neovim's 'tabline' option to use the custom function
-- The '%!v:lua.' prefix tells Neovim to evaluate a Lua expression
vim.o.tabline = "%!v:lua.my_tabline()"
