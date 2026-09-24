return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		{
			'lewis6991/foldsigns.nvim',
			config = function()
				require('foldsigns').setup {}
			end
		}
	},
	init = function()
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldnestmax = 99
		vim.o.foldenable = true
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.foldcolumn = '1'
		vim.g.foldmin = 2
	end,
	opts = function()
		require('ufo').setup({
			open_fold_hl_timeout = 150,
			provider_selector = function()
				return { 'treesitter' }
			end,
		})

		local wrap = function(func, ...)
			local args = { ... }
			return function()
				func(unpack(args))
			end
		end

		local return_or_open_fold = function()
			local lnr = vim.api.nvim_command_output('echo foldclosed(line("."))')
			local cmd = "<return>"
			if lnr ~= '-1' then
				cmd = "zOj^"
			end
			local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
		end

		local closeMinFold = function()
			local c = 99
			while tonumber(vim.api.nvim_command_output('echo foldlevel(line("."))')) > vim.g.foldmin do
				require('ufo').goPreviousStartFold()
				c = c - 1
				if c < 0 then
					break
				end
			end
			vim.cmd('foldclose')
			local keys = vim.api.nvim_replace_termcodes("zz", true, false, true)
			vim.api.nvim_feedkeys(keys, "n", false)
		end

		local set_foldmin_level = function(value)
			vim.g.foldmin = value
			print("foldmin: " .. value)
		end

		vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
		vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
		vim.keymap.set('n', 'zm', wrap(require('ufo').closeFoldsWith, vim.g.foldmin - 1))
		vim.keymap.set('n', '<return>', return_or_open_fold)
		vim.keymap.set('n', 'zc', closeMinFold)
		vim.keymap.set('n', 'z0', wrap(set_foldmin_level, 1))
		vim.keymap.set('n', 'z1', wrap(set_foldmin_level, 2))
		vim.keymap.set('n', 'z2', wrap(set_foldmin_level, 3))
	end,
}
