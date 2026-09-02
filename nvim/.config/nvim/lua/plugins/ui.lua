return {
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require('nvim-tree').setup({
				sort = { sorter = 'case_sensitive' },
				view = { width = 32, side = 'left', signcolumn = 'yes' },
				filters = { dotfiles = false },
				git = { enable = true },
				renderer = {
					add_trailing = true,
					group_empty = true,
					root_folder_label = ':~:s?$?/..?',
					highlight_git = 'name',
					highlight_opened_files = 'name',
					indent_markers = {
						enable = true,
						-- icons = { corner = '╰', edge = '│', item = '│', none = ' ' },
					},
					icons = {
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = true,
						},
						git_placement = 'after',
						glyphs = {
							-- folder + unmerged/deleted use nvim-tree Nerd Font defaults
							git = {
								unstaged = '●',
								staged = '✓',
								renamed = '➜',
								untracked = '★',
								ignored = '◌',
							},
						},
					},
				},
			})

			-- Theme-driven accents; re-derived on each ColorScheme
			local function tree_hl()
				local m = require('config.palette').get()
				local set = function(g, s)
					vim.api.nvim_set_hl(0, g, s)
				end
				-- Detect if transparency is enabled (check if transparent.nvim is loaded and active)
				local is_transparent = vim.fn.exists(':TransparentToggle') == 2
				local tbg = is_transparent and 'NONE' or m.bg
				local raised_bg = is_transparent and 'NONE' or m.bg_raised

				set('NvimTreeNormal', { bg = tbg, fg = m.fg })
				set('NvimTreeEndOfBuffer', { bg = tbg })
				set('NvimTreeWinSeparator', { bg = tbg, fg = m.muted })
				set('NvimTreeRootFolder', { fg = m.violet, bold = true })
				set('NvimTreeFolderIcon', { fg = m.violet })
				set('NvimTreeFolderName', { fg = m.blue })
				set('NvimTreeOpenedFolderName', { fg = m.blue, bold = true })
				set('NvimTreeIndentMarker', { fg = m.muted })
				set('NvimTreeGitDirty', { fg = m.yellow })
				set('NvimTreeGitNew', { fg = m.green })
				set('NvimTreeGitDeleted', { fg = m.red })
				set('NvimTreeGitStaged', { fg = m.cyan })
				set('NvimTreeSpecialFile', { fg = m.orange, underline = true })
				set('NvimTreeCursorLine', { bg = raised_bg })
			end
			tree_hl()
			-- Re-run on ColorScheme and when transparent is toggled
			vim.api.nvim_create_autocmd('ColorScheme', { callback = tree_hl })
			-- Hook into transparent.nvim's toggle to update tree highlights
			vim.api.nvim_create_autocmd('User', {
				pattern = 'TransparentEnable,TransparentDisable',
				callback = tree_hl,
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

			-- close tree from anywhere if it's open, else close the buffer
			vim.keymap.set('n', '<leader>q', function()
				if api.tree.is_visible() then
					api.tree.close()
				else
					vim.cmd('BufferClose')
				end
			end, { desc = 'Close tree or buffer' })
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			current_line_blame = true,
			current_line_blame_opts = { delay = 300 },
		},
	},
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
				separator = { left = '▎', right = '' },
				separator_at_end = false,
				modified = { button = '●' },
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = 'ﬀ' },
					[vim.diagnostic.severity.WARN] = { enabled = false },
					[vim.diagnostic.severity.INFO] = { enabled = false },
					[vim.diagnostic.severity.HINT] = { enabled = true },
				},
				gitsigns = {
					added = { enabled = true, icon = '+', hl = 'BufferCurrentAddedSign' },
					changed = { enabled = true, icon = '~', hl = 'BufferCurrentChangedSign' },
					deleted = { enabled = true, icon = '-', hl = 'BufferCurrentDeletedSign' },
				},
				filetype = {
					custom_colors = false,
					enabled = false,
				},
			},
		},
		version = '^1.0.0',
		config = function(_, opts)
			require('barbar').setup(opts)

			-- Theme-driven restyle: accent active tab, muted dimmed rest.
			local hl = function(group, spec)
				vim.api.nvim_set_hl(0, group, spec)
			end

			-- Re-derive from the active theme on each ColorScheme (base16/transparent
			-- clobber Buffer* groups after setup, so this must re-run anyway).
			local function apply_hl()
				local P = require('config.palette').get()
				-- Transparency toggle: set bg/raised to 'NONE' to make barbar transparent.
				local bg = P.bg
				local raised = P.bg_raised
				hl('BufferTabpageFill', { bg = bg })
				-- Active buffer: raised bg, accent + bold to stand out
				hl('BufferCurrent', { fg = P.fg, bg = raised, bold = true })
				hl('BufferCurrentSign', { fg = P.violet, bg = raised })
				hl('BufferCurrentMod', { fg = P.orange, bg = raised, bold = true })
				hl('BufferCurrentIndex', { fg = P.violet, bg = raised })
				-- Visible (open in another window): mid emphasis
				hl('BufferVisible', { fg = P.subtle, bg = bg })
				hl('BufferVisibleSign', { fg = P.muted, bg = bg })
				hl('BufferVisibleMod', { fg = P.orange, bg = bg })
				-- Inactive: dimmed
				hl('BufferInactive', { fg = P.muted, bg = bg })
				hl('BufferInactiveSign', { fg = P.muted, bg = bg })
				hl('BufferInactiveMod', { fg = P.orange, bg = bg })
				-- Git status
				hl('BufferCurrentAddedSign', { fg = P.green, bg = raised })
				hl('BufferCurrentChangedSign', { fg = P.yellow, bg = raised })
				hl('BufferCurrentDeletedSign', { fg = P.red, bg = raised })
			end
			apply_hl()
			vim.api.nvim_create_autocmd('ColorScheme', { callback = apply_hl })

			local map = vim.api.nvim_set_keymap
			local key_opts = { noremap = true, silent = true }

			map('n', '<leader>,', '<Cmd>BufferPrevious<CR>', key_opts)
			map('n', '<leader>.', '<Cmd>BufferNext<CR>', key_opts)
			-- <leader>q lives in nvim-tree config: closes tree if open, else buffer

			-- alt+comma/period: next/prev
			map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', key_opts)
			map('n', '<A-.>', '<Cmd>BufferNext<CR>', key_opts)
			-- alt+</> : re-order buffer left/right
			map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', key_opts)
			map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', key_opts)
			-- pin / pick-close
			map('n', '<leader>bj', '<Cmd>BufferPick<CR>', key_opts)
			map('n', '<leader>bp', '<Cmd>BufferPin<CR>', key_opts)
			map('n', '<leader>bc', '<Cmd>BufferPickDelete<CR>', key_opts)
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
				shade_terminals = false, -- follows theme Normal/FloatBorder (dynamic)
				float_opts = {
					border = 'curved',
					winblend = 0,
				},
			})

			vim.keymap.set('n', '<leader>h', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Toggle floating terminal' })
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
	{
		'X3eRo0/dired.nvim',
		dependencies = { 'MunifTanjim/nui.nvim' },
		config = function()
			require('dired').setup({
				path_separator = '/',
				show_banner = false,
				show_icons = false,
				show_hidden = true,
				show_dot_dirs = true,
				show_colors = true,
				hide_details = false,
				sort_order = 'name',
				override_cwd = true,
			})
			vim.keymap.set('n', '<leader>-', '<Cmd>Dired<CR>', { desc = 'Open Dired' })
		end,
	},
}
