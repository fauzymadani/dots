return {
	{
		'epwalsh/obsidian.nvim',
		version = '*',
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand "~" .. "/Documents/Obsidian Vault/**.md",
			"BufNewFile " .. vim.fn.expand "~" .. "/Documents/Obsidian Vault/**.md",
		},
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		opts = {
			workspaces = {
				{
					name = 'personal',
					path = '~/Documents/Obsidian Vault',
				},
			},
		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup({})
			require('nvim-treesitter').install({ 'markdown', 'markdown_inline', 'lua', 'vim', 'vimdoc', 'latex' })
		end,
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons', -- if you prefer nvim-web-devicons
		},
		ft = { 'markdown', 'rmd' },
		opts = {
			latex = {
				enabled = true,
				converter = 'latex2text',
			},
		},
	},
	{
		'YousefHadder/markdown-plus.nvim',
		ft = { 'markdown' },
		opts = {},
	},
}
