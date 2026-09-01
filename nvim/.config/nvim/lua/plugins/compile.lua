return {
	{
		'ej-shafran/compile-mode.nvim',
		version = '^5.0.0',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ '<leader>cc', '<cmd>botright Compile<cr>', desc = 'Compile command' },
			{ '<leader>cr', '<cmd>botright Recompile<cr>', desc = 'Recompile last command' },
			{ '<leader>cn', '<cmd>NextError<cr>', desc = 'Next compilation error' },
			{ '<leader>cp', '<cmd>PrevError<cr>', desc = 'Previous compilation error' },
		},
		config = function()
			vim.g.compile_mode = {
				input_word_completion = true,
				default_command = {
					go = 'go test ./...',
				},
			}
		end,
	},
}
