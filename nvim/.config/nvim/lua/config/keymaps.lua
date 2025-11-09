vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local telescope_ok, builtin = pcall(require, 'telescope.builtin')

if telescope_ok then
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
end

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>n', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

local tree_ok, api = pcall(require, 'nvim-tree.api')
if tree_ok then
	vim.keymap.set('n', '<leader>e', function()
		api.tree.toggle()
	end, { desc = 'Toggle tree' })

	vim.keymap.set('n', '<leader>q', function()
		if vim.bo.filetype == 'NvimTree' then
			api.tree.close()
		else
			vim.cmd('q')
		end
	end, { desc = 'Close tree or buffer' })
end

-- harpoon keymaps
vim.keymap.set('n', '<leader>a', function()
	harpoon:list():add()
end)
vim.keymap.set('n', '<C-e>', function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

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

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set('n', '<C-S-P>', function()
	harpoon:list():prev()
end)
vim.keymap.set('n', '<C-S-N>', function()
	harpoon:list():next()
end)

-- Select all text in the file
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all text' })
