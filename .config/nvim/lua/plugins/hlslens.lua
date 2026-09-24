return {
	'kevinhwang91/nvim-hlslens',
	config = function()

		require('hlslens').setup({
			calm_down = true,
			override_lens = function(render, posList, nearest, idx)
				local text, chunks
				local lnum, col = unpack(posList[idx])
				if nearest then
					local cnt = #posList
					text = (' [ %d/%d ]'):format(idx, cnt)
					chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
				else
					text = ('[ %d ]'):format(idx)
					chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
				end
				render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
			end
		})

		vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = true, silent = true })
		vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
			{ noremap = true, silent = true })
	end
}
