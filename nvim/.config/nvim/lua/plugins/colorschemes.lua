colorschemes = {
	'navarasu/onedark.nvim', "oskarnurm/koda.nvim", "serhez/teide.nvim", "rafamadriz/neon", "sainnhe/edge",
	"marko-cerovac/material.nvim", "everviolet/nvim", "nyoom-engineering/oxocarbon.nvim",
	"rockerBOO/boo-colorscheme-nvim", "datsfilipe/vesper.nvim"
}

M = {}

for _, v in ipairs(colorschemes) do
	table.insert(M, {
		string.format("%s", v),
		lazy = true,
		priority = 1000
	})
end

return M
