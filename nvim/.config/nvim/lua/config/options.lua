vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

-- Reload buffers when files change on disk (e.g. edited by Claude in another tab)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
	command = 'checktime',
})
