vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

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
