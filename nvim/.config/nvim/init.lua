-- Basic settings
require('config.options')
require('config.keymaps')

-- Lazy.nvim setup
vim.opt.rtp:prepend('~/.local/share/nvim/lazy/lazy.nvim')
require('lazy').setup('plugins')

vim.wo.relativenumber = true

vim.opt.conceallevel = 1

vim.o.background = 'dark'
local theme_ok, theme_error = pcall(dofile, vim.fn.stdpath('config') .. '/theme.lua')
if not theme_ok then
	vim.notify('Could not load saved colorscheme: ' .. theme_error, vim.log.levels.WARN)
	vim.cmd.colorscheme('rose-pine')
end

vim.api.nvim_create_autocmd('ColorScheme', {
	callback = function(opts)
		local f = io.open(vim.fn.stdpath('config') .. '/theme.lua', 'w')
		if f then
			f:write(string.format('vim.cmd.colorscheme(%q)\n', opts.match))
			f:close()
		end
	end,
})
