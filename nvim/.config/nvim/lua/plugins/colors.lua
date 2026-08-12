return {
	{ 'RRethy/base16-nvim' },
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
	-- Transparency disabled (terminal is opaque). Uncomment this whole block +
	-- flip the `local bg`/`local raised` toggles in ui.lua to re-enable.
	--[[
	{
		'xiyaowong/transparent.nvim',
		config = function()
			require('transparent').setup({
				extra_groups = {
					'TelescopeNormal',
					'TelescopeBorder',
					'TelescopePromptNormal',
					'TelescopePromptBorder',
					'TelescopeResultsNormal',
					'TelescopeResultsBorder',
					'TelescopePreviewNormal',
					'TelescopePreviewBorder',
					'WhichKey',
					'WhichKeyNormal',
					'WhichKeyBorder',
					'WhichKeyFloat',
					'DiffviewNormal',
					'DiffviewFilePanelTitle',
					'DiffviewFilePanelCounter',
					'DiffviewFilePanelFileName',
					'NormalFloat',
					'FloatBorder',
					'FloatTitle',
				},
			})
		end,
	},
	]]
}
