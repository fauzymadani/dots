vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- formatting: python follows PEP 8 (4 spaces); c/c++ stay 2-wide like the rest
-- of the config. expandtab keeps files portable (no literal tab characters).
-- these widths must match the clang-format options in lua/plugins/lsp.lua and
-- the bodies of the snippets in lua/snippets/.
vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'python' },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'c', 'cpp' },
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
	end,
})

vim.opt.laststatus = 2

local function lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ''
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return '  ' .. table.concat(names, ',')
end

vim.opt.statusline = table.concat({
	'%f',
	'%m',
	'  ',
	'%=',
	'%{&fileformat}',
	'  ',
	'%{(&fenc == "" ? &enc : &fenc)}',
	'  ',
	'%l:%c',
	'  ',
	'%p%%',
	'%{v:lua.lsp_status()}',
}, '')

_G.lsp_status = lsp_status
vim.api.nvim_create_autocmd({ 'LspAttach', 'LspDetach' }, {
	callback = function()
		vim.cmd('redrawstatus')
	end,
})

-- Reload buffers when files change on disk
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
	command = 'checktime',
})
