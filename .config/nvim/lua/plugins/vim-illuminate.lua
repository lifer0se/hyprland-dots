return {
	"RRethy/vim-illuminate",

	config = function()
		require('illuminate').configure({
			providers = {
				'lsp',

			},
			filetypes_denylist = {
				'nvim-tree',
				'neo-tree',
			},
			min_count_to_highlight = 2,
		})
	end,
}
