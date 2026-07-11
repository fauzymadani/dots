return {
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			-- Catppuccin Mocha: very faint guides, no scope line (less noise + zero per-move cost)
			local function ibl_hl()
				vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#252534' }) -- almost invisible
			end
			ibl_hl()
			vim.api.nvim_create_autocmd('ColorScheme', { callback = ibl_hl })

			require('ibl').setup({
				indent = { char = '│', highlight = 'IblIndent' },
				scope = { enabled = false },
			})
		end,
	},
}
