vim.opt.clipboard = 'unnamedplus'
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.laststatus = 2 -- selalu tampilkan statusline (2 = selalu, 3 = global satu bar buat semua window)

vim.opt.statusline = table.concat({
	'%f',
	' %m',
	'%=',
	'%{&fileformat}',
	'  ',
	'%{(&fenc == "" ? &enc : &fenc)}',
	'   ',
	'%l:%c',
	'   ',
	' %p%%',
	'   ',
}, '')

-- Reload buffers when files change on disk (e.g. edited by Claude in another tab)
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
	command = 'checktime',
})
