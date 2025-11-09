return {
	{ 'RRethy/base16-nvim' },
	{ 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
	{
		'uZer/pywal16.nvim',
	},
	{
		'e-ink-colorscheme/e-ink.nvim',
		priority = 1000,
		config = function()
			require('e-ink').setup()
		end,
	},
}
