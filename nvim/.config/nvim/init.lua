-- Basic settings
require('config.options')
require('config.keymaps')

-- Lazy.nvim setup
vim.opt.rtp:prepend('~/.local/share/nvim/lazy/lazy.nvim')
require('lazy').setup('plugins')

vim.api.nvim_set_hl(0, 'Visual', { bg = '#44475a', fg = 'NONE' })

vim.cmd.colorscheme('base16-rose-pine')
