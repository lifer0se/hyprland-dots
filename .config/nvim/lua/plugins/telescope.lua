return {
	'nvim-telescope/telescope.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-telescope/telescope-fzy-native.nvim',
		'nvim-telescope/telescope-ui-select.nvim'
	},
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n', '<leader>fg', function()
			builtin.grep_string({ search = vim.fn.input("grep: ") })
		end)

		require('telescope').setup {
			defaults = {
				prompt_prefix = '❯ ',
				hidden = true,
			},
			pickers = {
				find_files = {
					layout_config = {
						preview_width = 0.6,
					},
				},
				help_tags = {
					layout_config = {
						preview_width = 0.7,
					},
				},
				current_buffer_fuzzy_find = {
					sorting_strategy = 'ascending',
					layout_config = {
						preview_width = 0.5,
					},
				},
			},
			extensions = {
				fyz_native = {
					override_generic_order = false,
					override_files_sorter = true,
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown {
					}
				}
			}
		}
		require('telescope').load_extension('fzy_native')
		require('telescope').load_extension('ui-select')
	end,
}
