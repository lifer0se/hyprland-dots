local function create_augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
	group = create_augroup("highlight_yank"),
	pattern = "*",
	desc = "Highlight selection on yank.",
	callback = function()
		vim.highlight.on_yank({ timeout = 150, visual = true })
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = create_augroup("vertical_help"),
	pattern = "help",
	desc = "Open help windows in a vertical split.",
	callback = function()
		vim.bo.bufhidden = "unload"
		vim.cmd.wincmd("L")
		vim.cmd.wincmd("=")
	end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = create_augroup("glsl_filetypes"),
	pattern = { "*.vert", "*.frag", "*.comp", "*.rchit", "*.rmiss", "*.rahit " },
	desc = "Changes .frag and .vert files to glsl filetype for lsp use.",
	callback = function()
		vim.cmd('set filetype=glsl')
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = create_augroup("wrap_plain_text"),
	pattern = { "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes.",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end
})

vim.api.nvim_create_autocmd("FileType", {
	group = create_augroup("disable_autocomment"),
	pattern = "*",
	desc = "Disables autocomment on new line for all filetypes",
	callback = function()
		vim.cmd('setlocal formatoptions-=c formatoptions-=r formatoptions-=o')
	end
})

vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("WinResize", { clear = true }),
	pattern = "*",
	command = "wincmd =",
	desc = "Auto-resize windows on terminal buffer resize.",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("trim_format_on_save", { clear = true }),
	pattern = "*",
	desc = "Remove whitespace and lsp Format if available.",
	callback = function()
		vim.cmd('%s/\\s\\+$//e')
		vim.cmd('%s/\\n\\+\\%$//e')
	end,
})
