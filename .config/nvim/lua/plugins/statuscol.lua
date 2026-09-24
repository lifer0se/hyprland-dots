return {
	"luukvbaal/statuscol.nvim",
	config = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			foldfunc = "builtin",
			setopt = true,
			relculright = true,
			segments = {
				{ text = { builtin.foldfunc },      click = "v:lua.ScFa" },
				{ text = { "%s" },                  click = "v:lua.ScLa" },
				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScSa", },
			}
		})
	end,
}
