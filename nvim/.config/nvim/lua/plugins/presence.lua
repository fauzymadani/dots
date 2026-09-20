return {
	{
		'vyfor/cord.nvim',
		build = ':Cord update',
		event = 'VeryLazy',
		opts = {
			display = {
				theme = 'default',
			},
			text = {
				editing = 'Editing something...',
				reading = 'Reading in Neovim',
				viewing = 'Browsing files',
				workspace = 'Working on something...',
			},
		},
	},
}
