return {
	{ 'oskarnurm/koda.nvim' },
	{ 'harshrajsachan/omni.nvim' },
	{ 'nickkadutskyi/jb.nvim' },
	{ 'wtfox/luna.nvim' },
	{ 'shaunsingh/nord.nvim' },
	{ 'miikanissi/modus-themes.nvim' },
	{ 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },
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
	{
		'xiyaowong/transparent.nvim',
		config = function()
			require('transparent').setup({
				extra_groups = {
					'StatusLine',
					'StatusLineNC',
					-- Floating windows (docs, signature, diagnostics)
					'NormalFloat',
					'FloatBorder',
					'FloatTitle',
					-- Diagnostic floating window
					'DiagnosticFloating',
					'DiagnosticFloatingError',
					'DiagnosticFloatingWarn',
					'DiagnosticFloatingInfo',
					'DiagnosticFloatingHint',
					-- Diagnostic base groups
					'DiagnosticError',
					'DiagnosticWarn',
					'DiagnosticInfo',
					'DiagnosticHint',
					'LspSignatureActiveParameter',
					-- File tree
					'NvimTreeNormal',
					'NvimTreeEndOfBuffer',
					'NvimTreeWinSeparator',
					-- Telescope
					'TelescopeNormal',
					'TelescopeBorder',
					'TelescopePromptNormal',
					'TelescopePromptBorder',
					'TelescopeResultsNormal',
					'TelescopeResultsBorder',
					'TelescopePreviewNormal',
					'TelescopePreviewBorder',
					-- Which-key
					'WhichKey',
					'WhichKeyNormal',
					'WhichKeyBorder',
					'WhichKeyFloat',
					-- Diffview
					'DiffviewNormal',
					'DiffviewFilePanelTitle',
					'DiffviewFilePanelCounter',
					'DiffviewFilePanelFileName',
				},
			})
			-- Force statusline to remain opaque with palette colors
			vim.api.nvim_create_autocmd('User', {
				pattern = 'TransparentEnable,TransparentDisable',
				callback = function()
					local P = require('config.palette').get()
					vim.api.nvim_set_hl(0, 'StatusLine', { fg = P.fg, bg = P.bg, bold = true })
					vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = P.muted, bg = P.bg })
				end,
			})
			-- Set statusline colors on startup
			local P = require('config.palette').get()
			vim.api.nvim_set_hl(0, 'StatusLine', { fg = P.fg, bg = P.bg, bold = true })
			vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = P.muted, bg = P.bg })
		end,
	},
}
