return {
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {
			indent = { char = '│', highlight = 'Whitespace' },
			scope = { enabled = false },
		},
	},
}
