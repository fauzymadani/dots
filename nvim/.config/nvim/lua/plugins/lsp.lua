return {
	{
		'williamboman/mason.nvim',
		build = ':MasonUpdate',
		config = true,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		dependencies = {
			'williamboman/mason.nvim',
			'neovim/nvim-lspconfig',
		},
		config = function()
			local mason_lspconfig = require('mason-lspconfig')
			mason_lspconfig.setup({
				ensure_installed = { 'lua_ls', 'gopls', 'intelephense' },
				automatic_installation = true,
			})

			-- lua
			vim.lsp.config.lua_ls = {
				cmd = { 'lua-language-server' },
				settings = {
					Lua = {
						diagnostics = { globals = { 'vim' } },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
						telemetry = { enable = false },
					},
				},
			}

			-- go
			vim.lsp.config.gopls = {
				cmd = { 'gopls' },
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
					},
				},
			}

			-- php
			vim.lsp.config.intelephense = {
				cmd = { 'intelephense', '--stdio' },
				filetypes = { 'php' },
				root_markers = { 'composer.json', '.git', '.env' },
				settings = {
					intelephense = {
						files = {
							maxSize = 5000000,
						},
						environment = {
							includePaths = {},
						},
					},
				},
			}

			vim.lsp.enable('lua_ls')
			vim.lsp.enable('gopls')
			vim.lsp.enable('intelephense')
		end,
	},
	{
		'ray-x/lsp_signature.nvim',
		event = 'VeryLazy',
		opts = {
			hint_enable = false,
			handler_opts = {
				border = 'rounded',
			},
		},
		config = function(_, opts)
			require('lsp_signature').setup(opts)
		end,
	},
	{
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		opts = {
			formatters_by_ft = {
				lua = { 'stylua' },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters = {
				stylua = {
					prepend_args = { '--config-path', vim.fn.expand('~/dotfiles/nvim/.config/nvim/stylua.toml') },
				},
			},
		},
	},
}
