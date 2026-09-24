return {
	"hoob3rt/lualine.nvim",
	config = function()
		local custom_theme = require 'lualine.themes.palenight'
		custom_theme.normal.c.bg = '#202230'
		custom_theme.inactive.c.bg = '#202230'

		require 'lualine'.setup {
			options = {
				icons_enabled = true,
				theme = custom_theme,
				component_separators = { '', '' },
				section_separators = { '', '' },
				-- disabled_filetypes = { 'neo-tree', 'alpha' },
				symbols = { error = '● ', warn = '● ', info = '● ', hint = '● ' }
			},
			sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch', 'diff' },
				lualine_c = { 'filename' },
				lualine_x = { 'filetype' },
				lualine_y = { { 'diagnostics', sources = { 'nvim_diagnostic' } }, 'progress' },
				lualine_z = { 'location' }
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { 'filename' },
				lualine_x = { 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' }
			},
			tabline = {},
			extensions = {},
		}
	end,
}
