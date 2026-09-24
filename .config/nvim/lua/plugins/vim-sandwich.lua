return {
	'machakann/vim-sandwich',
	config = function()
		vim.cmd("let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)")
	end,
}
