return {
	"nvim-treesitter/nvim-treesitter",
	build = function()
		require("nvim-treesitter.install").update({ with_sync = true })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nushell/tree-sitter-nu",
	},
	config = function()
		require('nvim-treesitter.config').setup {
			ensure_installed = { "lua" },
			sync_install = false,
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true
			},
		}
	end,
}
