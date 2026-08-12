return {
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			-- CosmicInk-style statusline, personalized to Rose Pine.
			-- Based on Yeeloman's CosmicInk (MIT).
			-- Palette derived from the active theme; refreshed on ColorScheme.
			local colors = {}
			local all_colors = {}
			local function refresh_palette()
				local P = require('config.palette').get()
				colors.BG = P.bg
				colors.FG = P.fg
				colors.YELLOW = P.yellow
				colors.CYAN = P.cyan
				colors.DARKBLUE = P.violet -- normal-mode accent
				colors.GREEN = P.green
				colors.ORANGE = P.orange
				colors.VIOLET = P.violet
				colors.MAGENTA = P.magenta
				colors.BLUE = P.blue
				colors.RED = P.red
				all_colors = {
					colors.RED, colors.BLUE, colors.GREEN, colors.MAGENTA,
					colors.ORANGE, colors.CYAN, colors.VIOLET, colors.YELLOW, colors.DARKBLUE,
				}
			end
			refresh_palette()
			vim.api.nvim_create_autocmd('ColorScheme', { callback = refresh_palette })

			local function get_mode_color()
				local mode_color = {
					n = colors.DARKBLUE,
					i = colors.GREEN,
					v = colors.VIOLET,
					[''] = colors.VIOLET,
					V = colors.VIOLET,
					c = colors.ORANGE,
					no = colors.RED,
					s = colors.ORANGE,
					S = colors.ORANGE,
					[''] = colors.ORANGE,
					ic = colors.YELLOW,
					R = colors.RED,
					Rv = colors.RED,
					cv = colors.ORANGE,
					ce = colors.ORANGE,
					r = colors.CYAN,
					rm = colors.CYAN,
					['r?'] = colors.CYAN,
					['!'] = colors.RED,
					t = colors.CYAN,
				}
				return mode_color[vim.fn.mode()] or colors.FG
			end

			local function get_opposite_color(mode_color)
				local opposite_colors = {
					[colors.RED] = colors.CYAN,
					[colors.BLUE] = colors.ORANGE,
					[colors.GREEN] = colors.MAGENTA,
					[colors.MAGENTA] = colors.DARKBLUE,
					[colors.ORANGE] = colors.BLUE,
					[colors.CYAN] = colors.YELLOW,
					[colors.VIOLET] = colors.GREEN,
					[colors.YELLOW] = colors.RED,
					[colors.DARKBLUE] = colors.VIOLET,
				}
				return opposite_colors[mode_color] or colors.FG
			end

			local function get_animated_color(mode_color)
				local possible = {}
				for _, color in ipairs(all_colors) do
					if color ~= mode_color then
						table.insert(possible, color)
					end
				end
				if #possible > 0 then
					return possible[math.random(1, #possible)]
				end
				return colors.FG
			end

			local function interpolate_color(color1, color2, step)
				local blend = function(c1, c2, stp)
					return math.floor(c1 + (c2 - c1) * stp)
				end
				local r1, g1, b1 = tonumber(color1:sub(2, 3), 16), tonumber(color1:sub(4, 5), 16), tonumber(color1:sub(6, 7), 16)
				local r2, g2, b2 = tonumber(color2:sub(2, 3), 16), tonumber(color2:sub(4, 5), 16), tonumber(color2:sub(6, 7), 16)
				return string.format('#%02X%02X%02X', blend(r1, r2, step), blend(g1, g2, step), blend(b1, b2, step))
			end

			local function get_middle_color(color_step)
				color_step = color_step or 0.5
				local color1 = get_mode_color()
				return interpolate_color(color1, get_opposite_color(color1), color_step)
			end

			local function hide_in_width()
				return vim.fn.winwidth(0) > 80
			end

			math.randomseed(os.time())
			local icon_sets = {
				stars = { '★', '☆', '✧', '✦', '✶', '✷', '✸', '✹' },
				runes = {
					'✠',
					'⛧',
					'𖤐',
					'ᛟ',
					'ᚨ',
					'ᚱ',
					'ᚷ',
					'ᚠ',
					'ᛉ',
					'ᛊ',
					'ᛏ',
					'☠',
					'☾',
					'♰',
					'✟',
					'☽',
					'⚚',
					'🜏',
				},
				hearts = { '❤', '♥', '♡', '❦', '❧' },
				waves = { '≈', '∿', '≋', '≀', '⌀', '≣', '⌇' },
				crosses = { '☨', '✟', '♰', '♱', '⛨' },
			}
			local function get_random_icon(icons)
				return icons[math.random(#icons)]
			end
			local function shuffle_table(tbl)
				local n = #tbl
				while n > 1 do
					local k = math.random(n)
					tbl[n], tbl[k] = tbl[k], tbl[n]
					n = n - 1
				end
			end
			local icon_sets_list = {}
			for _, icons in pairs(icon_sets) do
				table.insert(icon_sets_list, icons)
			end
			shuffle_table(icon_sets_list)
			local function reverse_table(tbl)
				local reversed = {}
				for i = #tbl, 1, -1 do
					table.insert(reversed, tbl[i])
				end
				return reversed
			end
			local reversed_icon_sets = reverse_table(icon_sets_list)

			local function create_separator(side, use_mode_color)
				return {
					function()
						return side == 'left' and '' or ''
					end,
					color = function()
						local color = use_mode_color and get_mode_color() or get_opposite_color(get_mode_color())
						return { fg = color }
					end,
					padding = { left = 0 },
				}
			end

			local function create_mode_based_component(content, icon, color_fg, color_bg)
				return {
					content,
					icon = icon,
					color = function()
						local mode_color = get_mode_color()
						return {
							fg = color_fg or colors.FG,
							bg = color_bg or get_opposite_color(mode_color),
							gui = 'bold',
						}
					end,
				}
			end

			local function mode()
				local mode_map = {
					n = 'N',
					i = 'I',
					v = 'V',
					[''] = 'V',
					V = 'V',
					c = 'C',
					no = 'N',
					s = 'S',
					S = 'S',
					ic = 'I',
					R = 'R',
					Rv = 'R',
					cv = 'C',
					ce = 'C',
					r = 'R',
					rm = 'M',
					['r?'] = '?',
					['!'] = '!',
					t = 'T',
				}
				return mode_map[vim.fn.mode()] or '[UNKNOWN]'
			end

			local config = {
				options = {
					component_separators = '',
					section_separators = '',
					globalstatus = true,
					-- bg = 'NONE' inherits the window Normal bg, so the bar always matches
					-- the editor (and follows any theme) without baking a hex at setup time.
					theme = {
						normal = { c = { fg = colors.FG, bg = 'NONE' } },
						inactive = { c = { fg = colors.FG, bg = 'NONE' } },
					},
					-- globalstatus = one shared bar; disabling per-filetype hides it entirely
					disabled_filetypes = {},
				},
				sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {
						{
							'location',
							color = function()
								return { fg = colors.FG, gui = 'bold' }
							end,
						},
					},
					lualine_x = {
						{
							'filename',
							color = function()
								return { fg = colors.FG, gui = 'bold,italic' }
							end,
						},
					},
					lualine_y = {},
					lualine_z = {},
				},
			}

			local function ins_left(component)
				table.insert(config.sections.lualine_c, component)
			end
			local function ins_right(component)
				table.insert(config.sections.lualine_x, component)
			end

			-- LEFT
			ins_left({
				mode,
				color = function()
					return { fg = colors.BG, bg = get_mode_color(), gui = 'bold' }
				end,
				padding = { left = 1, right = 1 },
			})
			ins_left(create_separator('left', true))
			ins_left({
				function()
					return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
				end,
				icon = ' ',
				color = function()
					return { fg = get_mode_color(), gui = 'bold' }
				end,
			})
			ins_left(create_separator('right'))
			ins_left(create_mode_based_component('filename', nil, colors.BG))
			ins_left(create_separator('left'))
			ins_left({
				function()
					return ''
				end,
				color = function()
					return { fg = get_middle_color() }
				end,
				cond = hide_in_width,
			})
			ins_left({
				function()
					local git = vim.b.gitsigns_status_dict
					if git then
						return string.format('+%d ~%d -%d', git.added or 0, git.changed or 0, git.removed or 0)
					end
					return ''
				end,
				color = { fg = colors.YELLOW, gui = 'bold' },
				cond = hide_in_width,
			})
			for _, icons in pairs(icon_sets_list) do
				ins_left({
					function()
						return get_random_icon(icons)
					end,
					color = function()
						return { fg = get_animated_color() }
					end,
					cond = hide_in_width,
				})
			end
			ins_left({ 'searchcount', color = { fg = colors.GREEN, gui = 'bold' } })

			-- RIGHT
			ins_right({
				function()
					local reg = vim.fn.reg_recording()
					return reg ~= '' and '[' .. reg .. ']' or ''
				end,
				color = { fg = colors.RED, gui = 'bold' },
				cond = function()
					return vim.fn.reg_recording() ~= ''
				end,
			})
			ins_right({ 'selectioncount', color = { fg = colors.GREEN, gui = 'bold' } })
			for _, icons in ipairs(reversed_icon_sets) do
				ins_right({
					function()
						return get_random_icon(icons)
					end,
					color = function()
						return { fg = get_animated_color() }
					end,
					cond = hide_in_width,
				})
			end
			ins_right({
				function()
					local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
					local clients = vim.lsp.get_clients()
					if next(clients) == nil then
						return 'No LSP'
					end
					local short = {
						pyright = 'py',
						ts_ls = 'ts',
						tsserver = 'ts',
						rust_analyzer = 'rs',
						lua_ls = 'lua',
						clangd = 'c++',
						bashls = 'sh',
						jsonls = 'json',
						html = 'html',
						cssls = 'css',
						tailwindcss = 'tw',
						dockerls = 'docker',
						sqlls = 'sql',
						yamlls = 'yml',
					}
					for _, client in ipairs(clients) do
						local fts = client.config.filetypes
						if fts and vim.fn.index(fts, buf_ft) ~= -1 then
							return short[client.name] or client.name:sub(1, 2)
						end
					end
					return 'No LSP'
				end,
				icon = ' ',
				color = { fg = colors.YELLOW, gui = 'bold' },
			})
			ins_right({
				function()
					return ''
				end,
				color = function()
					return { fg = get_middle_color() }
				end,
				cond = hide_in_width,
			})
			ins_right(create_separator('right'))
			ins_right(create_mode_based_component('location', nil, colors.BG))
			ins_right(create_separator('left'))
			ins_right({
				'branch',
				icon = ' ',
				fmt = function(branch)
					if branch == '' or branch == nil then
						return 'No Repo'
					end
					local function truncate(seg, max)
						return #seg > max and seg:sub(1, max) or seg
					end
					local segments = {}
					for seg in branch:gmatch('[^/]+') do
						table.insert(segments, seg)
					end
					for i = 1, #segments - 1 do
						segments[i] = truncate(segments[i], 1)
					end
					if #segments == 1 then
						return segments[1]
					end
					segments[1] = segments[1]:upper()
					for i = 2, #segments - 1 do
						segments[i] = segments[i]:lower()
					end
					local out = table.concat(segments, '', 1, #segments - 1) .. '›' .. segments[#segments]
					if #out > 15 then
						out = out:sub(1, 15) .. '…'
					end
					return out
				end,
				color = function()
					return { fg = get_mode_color(), gui = 'bold' }
				end,
			})
			ins_right(create_separator('right'))
			ins_right(create_mode_based_component('progress', nil, colors.BG))

			require('lualine').setup(config)
		end,
	},
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
					group_empty = true,
					root_folder_label = ':~:s?$?/..?',
					highlight_git = 'name',
					highlight_opened_files = 'name',
					indent_markers = {
						enable = true,
						icons = { corner = '╰', edge = '│', item = '│', none = ' ' },
					},
					icons = {
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
				-- Transparency toggle: set tbg to 'NONE' to make the tree transparent.
				local tbg = m.bg
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
				set('NvimTreeCursorLine', { bg = m.bg_raised })
			end
			tree_hl()
			vim.api.nvim_create_autocmd('ColorScheme', { callback = tree_hl })

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
}
