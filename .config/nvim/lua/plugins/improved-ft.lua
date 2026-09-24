return {
	"backdround/improved-ft.nvim",
	config = function()
		require("improved-ft").setup({
			-- Maps default f/F/t/T/;/, keys.
			-- default: false
			use_default_mappings = true,
		})
	end,
}
