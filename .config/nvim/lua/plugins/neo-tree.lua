return {
	'nvim-neo-tree/neo-tree.nvim',
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require('neo-tree').setup {
			-- sources = {
			-- 	"document_symbols",
			-- },
			source_selector = {
				winbar = true,
				statusline = true
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
					hide_ignored = true,
					ignore_files = {
						".gd.uid"
					},
				}
			}
		}
	end,
}
