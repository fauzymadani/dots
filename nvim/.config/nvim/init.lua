vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.wrap = false

vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

-- Setup lazy
require("lazy").setup({
  -- Colorschemes
  { "RRethy/base16-nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Treesitter
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},

  -- Statusline
  { 'echasnovski/mini.statusline', version = false },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  -- Telescope
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Utilities
  {"BurntSushi/ripgrep"},
  { 'uZer/pywal16.nvim', as = 'pywal16' },
  {'nvim-tree/nvim-tree.lua'},
  { 'wakatime/vim-wakatime', lazy = false },
  {'lewis6991/gitsigns.nvim'},

  -- Mason + LSP
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" }
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip"
    }
  },
  {
   "e-ink-colorscheme/e-ink.nvim",
   priority = 1000,
   config = function ()
      require("e-ink").setup()
      vim.cmd.colorscheme "e-ink"

      -- choose light mode or dark mode
      -- vim.opt.background = "dark"
      vim.opt.background = "light"
      --
      -- or do
      -- :set background=dark
      -- :set background=light
   end
}
})

-- Mason setup
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "gopls" }, -- LSP Go
})

-- LSP setup
local lspconfig = require("lspconfig")
lspconfig.gopls.setup({}) -- pakai gopls langsung

-- Autocomplete setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
  })
})

-- Colorscheme
-- vim.cmd('colorscheme catppuccin-mocha')

-- Statusline
require("lualine").setup({
  options = {
    theme = "catppuccin"
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
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Telescope keymap
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- LSP keymap
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
vim.keymap.set("n", "<leader>n", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Nvim-tree keymap
local api = require("nvim-tree.api")
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

vim.keymap.set("n", "<leader>q", function()
  if vim.bo.filetype == "NvimTree" then
    api.tree.close()
  else
    vim.cmd("q") 
  end
end, { desc = "Close NvimTree if focused" })

