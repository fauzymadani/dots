vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', function()
	vim.lsp.buf.hover({ border = 'rounded' })
end, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
-- Same picker but for a visual selection (useful for whole-block refactors).
vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action (selection)' })
-- "Fix available" shortcut: applies the quick fix under the cursor straight
-- away when the server offers exactly one; otherwise shows the picker.
vim.keymap.set('n', '<leader>cf', function()
	vim.lsp.buf.code_action({
		apply = true,
		filter = function(action)
			-- keep quick fixes (and actions that do not declare a kind)
			return action.kind == nil or vim.startswith(action.kind, 'quickfix')
		end,
	})
end, { desc = 'Fix: apply quick fix under cursor' })
vim.keymap.set('n', '<leader>n', function()
	vim.diagnostic.open_float({ border = 'rounded' })
end, { desc = 'Show diagnostics' })
vim.diagnostic.config({ float = { border = 'rounded' } })
vim.keymap.set('n', '[d', function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = 'Previous diagnostic' })

vim.keymap.set('n', ']d', function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = 'Next diagnostic' })

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- Apply config edits without quitting Neovim (logic in lua/config/reload.lua).
-- <leader>rr: full restart; buffers, window layout and cwd are restored
--             (:restart, Nvim 0.12). Save your files first (:wa).
vim.keymap.set('n', '<leader>rr', '<Cmd>restart<CR>', { desc = 'Restart Nvim (reload full config)' })
-- <leader>rl: re-run config/options.lua + config/keymaps.lua in place.
--             NOTE: removing a mapping from the file still needs a restart.
vim.keymap.set('n', '<leader>rl', function()
	require('config.reload').apply('style')
end, { desc = 'Reload options + keymaps' })
-- <leader>ra: apply everything (options, keymaps, plugin specs, LSP servers).
vim.keymap.set('n', '<leader>ra', function()
	require('config.reload').apply('all')
end, { desc = 'Apply all config changes' })
-- <leader>rs: re-run lua/plugins/lsp.lua, then restart the attached servers.
vim.keymap.set('n', '<leader>rs', function()
	require('config.reload').apply('lsp')
end, { desc = 'Reload LSP config + restart servers' })

-- Same thing as a command, so it can also be pushed into a *different*
-- running session over RPC:
--   nvim --server <address> --remote-expr \
--     'luaeval("require(\"config.reload\").apply(\"all\")")'
vim.api.nvim_create_user_command('ConfigReload', function(opts)
	require('config.reload').apply(opts.args ~= '' and opts.args or 'all')
end, {
	nargs = '?',
	desc = 'Apply config changes to the running session (all|style|lsp)',
	complete = function()
		return { 'all', 'style', 'lsp' }
	end,
})

-- Resize the current split without repeating <C-w>.
vim.keymap.set('n', '<A-k>', '<Cmd>resize +2<CR>', { desc = 'Increase split height' })
vim.keymap.set('n', '<A-j>', '<Cmd>resize -2<CR>', { desc = 'Decrease split height' })
vim.keymap.set('n', '<A-h>', '<Cmd>vertical resize -3<CR>', { desc = 'Decrease split width' })
vim.keymap.set('n', '<A-l>', '<Cmd>vertical resize +3<CR>', { desc = 'Increase split width' })

-- tree keymaps (<leader>e) live in plugins/ui.lua nvim-tree config
-- buffer close (<leader>q) lives in plugins/ui.lua barbar config
-- Select all text in the file
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all text' })
