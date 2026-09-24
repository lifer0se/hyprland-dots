return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
		"windwp/nvim-autopairs",
	},
	config = function()
		local cmp = require('cmp')
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("nvim-autopairs").setup()
		cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

		require("luasnip.loaders.from_vscode").lazy_load()

		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		cmp.setup({
			preselect = cmp.PreselectMode.None,
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = {
				['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- elseif luasnip.expand_or_jumpable() then
						-- 	luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
						-- elseif luasnip.jumpable(-1) then
						-- 	luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			},

			formatting = {
				expandable_indicator = false,
				fields = {
					'abbr',
					'kind'
				},
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 40,
					ellipsis_char = "...",
					symbol_map = {
						Copilot = "",
					},
					before = function(entry, vim_item)
						vim_item.menu = ""
						return vim_item
					end
				}),
			},

			experimental = {
				ghost_text = true,
			},

			sources = cmp.config.sources {
				{ name = 'luasnip' },
				{ name = 'nvim_lsp' },
				{ name = 'nvim_lua' },
				{ name = 'path' },
				{ name = 'buffer' },
			},

		})

		cmp.setup.cmdline({ '/', '?' }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = 'buffer' }
			}
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline({
				["<Tab>"] = {
					c = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							local keymap = require('cmp.utils.keymap')
							if vim.fn.pumvisible() == 0 then
								vim.api.nvim_feedkeys(keymap.t('<C-z>'), 'in', true)
							else
								vim.api.nvim_feedkeys(keymap.t('<C-n>'), 'in', true)
							end
						end
					end,
				},
			}),
			sources = cmp.config.sources({
				{ name = 'cmdline' }
			})
		})
	end,
}
