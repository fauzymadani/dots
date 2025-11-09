return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('lualine').setup({
				options = { theme = 'auto' },
			})
		end,
	},
	{
		'nvim-tree/nvim-tree.lua',
		opts = {
			filters = {
				dotfiles = false,
			},
			view = {
				width = 35,
				side = 'left',
			},
			renderer = {
				group_empty = true,
			},
			git = {
				enable = true,
			},
		},
		config = function(_, opts)
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require('nvim-tree').setup({
				sort = { sorter = 'case_sensitive' },
				view = { width = 25 },
				renderer = { group_empty = true },
				filters = { dotfiles = true },
			})

			local api = require('nvim-tree.api')
			vim.keymap.set('n', '<leader>e', function()
				if api.tree.is_visible() then
					if vim.bo.filetype == 'NvimTree' then
						api.tree.toggle()
					else
						api.tree.focus()
					end
				else
					api.tree.open()
				end
			end, { desc = 'Toggle/focus tree' })

			vim.keymap.set('n', '<leader>q', function()
				if vim.bo.filetype == 'NvimTree' then
					api.tree.close()
				else
					vim.cmd('q')
				end
			end, { desc = 'Close tree' })
		end,
	},
	{ 'lewis6991/gitsigns.nvim', config = true },
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
		},
		config = function()
			local harpoon = require('harpoon')
			harpoon:setup()

			local conf = require('telescope.config').values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					table.insert(file_paths, item.value)
				end

				require('telescope.pickers')
					.new({}, {
						prompt_title = 'Harpoon',
						finder = require('telescope.finders').new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end

			vim.keymap.set('n', '<leader>a', function()
				harpoon:list():add()
			end)
			vim.keymap.set('n', '<C-e>', function()
				toggle_telescope(harpoon:list())
			end, { desc = 'Open harpoon' })
			vim.keymap.set('n', '<C-h>', function()
				harpoon:list():select(1)
			end)
			vim.keymap.set('n', '<C-t>', function()
				harpoon:list():select(2)
			end)
			vim.keymap.set('n', '<C-n>', function()
				harpoon:list():select(3)
			end)
			vim.keymap.set('n', '<C-s>', function()
				harpoon:list():select(4)
			end)
			vim.keymap.set('n', '<C-S-P>', function()
				harpoon:list():prev()
			end)
			vim.keymap.set('n', '<C-S-N>', function()
				harpoon:list():next()
			end)
		end,
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{
				'<leader>?',
				function()
					require('which-key').show({ global = false })
				end,
				desc = 'Buffer Local Keymaps (which-key)',
			},
		},
	},

	{
		'romgrk/barbar.nvim',
		dependencies = {
			'lewis6991/gitsigns.nvim',
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			icons = {
				buffer_index = false,
				buffer_number = false,
				button = '',
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				gitsigns = {
					added = { enabled = true, icon = '+' },
					changed = { enabled = true, icon = '~' },
					deleted = { enabled = true, icon = '-' },
				},
				filetype = {
					custom_colors = false,
					enabled = true,
				},
			},
		},
		version = '^1.0.0',
		config = function(_, opts)
			require('barbar').setup(opts)

			local map = vim.api.nvim_set_keymap
			local key_opts = { noremap = true, silent = true }

			map('n', '<leader>,', '<Cmd>BufferPrevious<CR>', key_opts)
			map('n', '<leader>.', '<Cmd>BufferNext<CR>', key_opts)
			map('n', '<leader>q', '<Cmd>BufferClose<CR>', key_opts)
		end,
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		config = function()
			local toggleterm = require('toggleterm')

			toggleterm.setup({
				size = 15,
				open_mapping = [[<C-\>]],
				start_in_insert = true,
				insert_mappings = true,
				terminal_mappings = true,
				persist_size = true,
				persist_mode = true,
				direction = 'float',
				shade_terminals = true,
				float_opts = {
					border = 'curved',
				},
			})

			vim.keymap.set('n', '<leader>h', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Toggle floating terminal' })
			vim.keymap.set('n', '<leader>v', '<cmd>ToggleTerm direction=vertical<CR>', { desc = 'Toggle vertical terminal' })
			vim.keymap.set('n', '<leader>t', '<cmd>ToggleTerm direction=tab<CR>', { desc = 'Toggle terminal in new tab' })

			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
				vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
				vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
				vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
				vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
			end

			vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
		end,
	},
}
