return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	opts = {
		org_agenda_files = "~/inbox.org",
		org_default_notes_file = "~/inbox.org",
		vim.lsp.enable("org"),
		org_log_done = false,
	},
}
