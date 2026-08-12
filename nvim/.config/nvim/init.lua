-- Basic settings
require('config.options')
require('config.keymaps')

-- Lazy.nvim setup
vim.opt.rtp:prepend('~/.local/share/nvim/lazy/lazy.nvim')
require('lazy').setup('plugins')
require('autoclose').setup()

vim.o.background = 'dark'
vim.cmd.colorscheme('rose-pine')
-- vim.cmd.colorscheme('base16-catppuccin-mocha')
