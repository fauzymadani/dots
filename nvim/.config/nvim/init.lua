vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Setup lazy
require("lazy").setup({
  -- Base16 colorscheme
  { "RRethy/base16-nvim" },
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  { 'echasnovski/mini.statusline', version = false },
  
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
  {"BurntSushi/ripgrep"},
  { 'uZer/pywal16.nvim', as = 'pywal16' },
  {'nvim-tree/nvim-tree.lua'},
  { 'wakatime/vim-wakatime', lazy = false },
  {'lewis6991/gitsigns.nvim'},
  
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
})

-- Set colorscheme
local pywal16 = require('pywal16')
pywal16.setup()

-- Statusline
-- require('mini.statusline').setup()
require("lualine").setup({
  options = {
    theme = "auto"
  }
})

-- disable netrw 
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup nvim-tree
require("nvim-tree").setup({
  sort = { sorter = "case_sensitive" },
  view = { width = 25 },
  renderer = { group_empty = true },
  filters = { dotfiles = true },
})

-- KEYMAP SECTION
-- set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- telescope keymap
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

local api = require("nvim-tree.api")

-- <leader> + e => toggle/focus nvim-tree
vim.keymap.set("n", "<leader>e", function()
  if api.tree.is_visible() then
    if vim.bo.filetype == "NvimTree" then
      api.tree.toggle() 
    else
      api.tree.focus()  
    end
  else
    api.tree.open()    
  end
end, { desc = "Toggle/focus NvimTree" })

-- <leader> + q => close nvim tree if the cursor currently focused on nvim-tree
vim.keymap.set("n", "<leader>q", function()
  if vim.bo.filetype == "NvimTree" then
    api.tree.close()
  else
    vim.cmd("q") -- fallback close buffer
  end
end, { desc = "Close NvimTree if focused" })

