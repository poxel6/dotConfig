return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "esmuellert/codediff.nvim",      -- optional

    "m00qek/baleia.nvim",            -- optional

    "nvim-telescope/telescope.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<A-j>", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
  }
}
