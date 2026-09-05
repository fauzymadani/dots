return {
	{
		'andweeb/presence.nvim',
		event = 'VeryLazy',
		config = function()
			require('presence').setup({
				auto_update = true,
				main_image = 'neovim',
				show_time = false,
				buttons = false,
				enable_line_number = false,
				editing_text = 'Editing something...',
				reading_text = 'Reading in Neovim',
				file_explorer_text = 'Browsing files',
				workspace_text = 'Working on something...',
				git_commit_text = 'Committing changes',
				plugin_manager_text = 'Managing plugins',
			})
		end,
	},
}
