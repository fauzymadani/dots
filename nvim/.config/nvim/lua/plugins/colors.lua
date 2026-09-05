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
				-- exclude_groups = { 'StatusLine', 'StatusLineNC' },
				extra_groups = {
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
					-- Markdown and Code blocks in Hover
					'markdownCode',
					'markdownCodeBlock',
					'@markup.raw',
					'@markup.raw.block',
					'@markup.raw.block.markdown',
					'@markup.raw.markdown_inline',
				},
			})
		end,
	},
}
