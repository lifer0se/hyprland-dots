return {
	"neovim/nvim-lspconfig",
	config = function()
		vim.keymap.set("n", "E", vim.lsp.buf.hover)
		vim.keymap.set("n", "<C-e>", vim.diagnostic.open_float)
		vim.keymap.set("n", "gn", function() vim.diagnostic.jump({count = 1}) end)
		vim.keymap.set("n", "ge", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end)
		vim.keymap.set("n", "gw", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end)
		vim.keymap.set("n", 'gl', vim.diagnostic.setqflist)
		vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
		vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references)
		vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations)
		vim.keymap.set('n', 'gs', require("telescope.builtin").lsp_document_symbols)
		vim.keymap.set('n', '<leader>ws', require("telescope.builtin").lsp_workspace_symbols)
		vim.keymap.set("n", '<leader>sc', vim.lsp.buf.rename)
		vim.keymap.set('n', 'gf', function() vim.lsp.buf.format { async = true } end)

		local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
		function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
			opts = opts or {}
			opts.border = opts.border or "rounded"
			return orig_util_open_floating_preview(contents, syntax, opts, ...)
		end

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "●",
					[vim.diagnostic.severity.WARN] = "●",
					[vim.diagnostic.severity.HINT] = "●",
					[vim.diagnostic.severity.INFO] = "●",
				},
				linehl = {
					-- [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					-- [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					-- [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					-- [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
				},
			},
			underline = { severity = 1 },
			update_in_insert = false,
			severity_sort = true,
			float = {
				focusable = true,
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			virtual_text = {
				prefix = '●',
				severity = 1,
			}
		})
	end,
}
