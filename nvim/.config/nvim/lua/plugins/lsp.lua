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

			-- mason installs its binaries into its own bin dir; fall back to that
			-- path when the executable is not on $PATH yet.
			local mason_bin = vim.fn.stdpath('data') .. '/mason/bin/'
			local function exe(name)
				if vim.fn.executable(name) == 1 then
					return name
				end
				if vim.fn.executable(mason_bin .. name) == 1 then
					return mason_bin .. name
				end
				return name
			end

			mason_lspconfig.setup({
				ensure_installed = { 'lua_ls', 'gopls', 'intelephense', 'pyright', 'clangd' },
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
				filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
				settings = {
					gopls = {
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
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

			-- python
			vim.lsp.config.pyright = {
				cmd = { exe('pyright-langserver'), '--stdio' },
				filetypes = { 'python' },
				root_markers = {
					'pyrightconfig.json',
					'pyproject.toml',
					'setup.py',
					'setup.cfg',
					'requirements.txt',
					'Pipfile',
					'.git',
				},
				settings = {
					python = {
						analysis = {
							typeCheckingMode = 'basic',
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = 'openFilesOnly',
							autoImportCompletions = true,
						},
					},
				},
			}

			-- c / c++
			vim.lsp.config.clangd = {
				cmd = {
					exe('clangd'),
					'--background-index',
					'--completion-style=detailed',
					'--header-insertion=never',
					'--enable-config',
					'--query-driver=/usr/bin/g++,/usr/bin/c++,/usr/bin/gcc*,/usr/bin/clang*',
				},
				filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
				root_markers = {
					'compile_commands.json',
					'compile_flags.txt',
					'.clangd',
					'CMakeLists.txt',
					'Makefile',
					'.git',
				},
			}

			vim.lsp.enable('lua_ls')
			vim.lsp.enable('gopls')
			vim.lsp.enable('intelephense')
			vim.lsp.enable('pyright')
			vim.lsp.enable('clangd')
		end,
	},
	{
		'ray-x/lsp_signature.nvim',
		event = 'VeryLazy',
		opts = {
			hint_enable = false,
			toggle_key = '<M-s>',
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
				go = { 'gofmt' },
				c = { 'clang-format' },
				cpp = { 'clang-format' },
			},
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters = {
				stylua = {
					prepend_args = { '--config-path', vim.fn.stdpath('config') .. '/stylua.toml' },
				},
				-- use the project style file when there is one, otherwise a sane fallback
				['clang-format'] = {
					prepend_args = function(_, ctx)
						local style_files = vim.fs.find({ '.clang-format', '_clang-format' }, { upward = true, path = ctx.dirname })
						if #style_files > 0 then
							return { '-style=file' }
						end
						return {
							'-style={BasedOnStyle: LLVM, IndentWidth: 2, TabWidth: 2, UseTab: Never, ColumnLimit: 100}',
						}
					end,
				},
			},
		},
	},
}
