-- Basic settings
require('config.options')
require('config.keymaps')

-- Lazy.nvim setup
vim.opt.rtp:prepend('~/.local/share/nvim/lazy/lazy.nvim')
require('lazy').setup('plugins')
require('autoclose').setup()

vim.wo.relativenumber = true

vim.opt.conceallevel = 1

vim.o.background = 'dark'
if not pcall(dofile, vim.fn.stdpath('config') .. '/theme.lua') then
	vim.cmd.colorscheme('rose-pine')
end

vim.api.nvim_create_autocmd('ColorScheme', {
	callback = function(opts)
		local f = io.open(vim.fn.stdpath('config') .. '/theme.lua', 'w')
		if f then
			f:write("vim.cmd.colorscheme('" .. opts.match .. "')")
			f:close()
		end
	end,
})
