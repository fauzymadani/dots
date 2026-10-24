return {
	{
		'mfussenegger/nvim-lint',
		event = { 'BufReadPost', 'BufNewFile' },
		config = function()
			local lint = require('lint')

			lint.linters_by_ft = {
				lua = { 'luacheck' },
				go = { 'golangcilint' },
				php = { 'phpstan' },
			}

			local warned = {}
			local function run_lint()
				local linters = lint.linters_by_ft[vim.bo.filetype]
				if not linters then
					return
				end

				for _, name in ipairs(linters) do
					local linter = lint.linters[name]
					if linter and vim.fn.executable(linter.cmd or name) == 1 then
						lint.try_lint(name)
						return
					end
					if not warned[name] then
						vim.notify(
							string.format('Linter "%s" is not installed', name),
							vim.log.levels.WARN
						)
						warned[name] = true
					end
				end
			end

			vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
				callback = run_lint,
			})

			vim.keymap.set('n', '<leader>xl', function()
				run_lint()
			end, { desc = 'Run linter' })
		end,
	},
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		opts = {},
		keys = {
			{
				's',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash jump',
			},
			{
				'S',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Flash Treesitter',
			},
		},
	},
	{
		'echasnovski/mini.ai',
		version = '*',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {},
	},
	{
		'echasnovski/mini.surround',
		version = '*',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = {},
	},
}
