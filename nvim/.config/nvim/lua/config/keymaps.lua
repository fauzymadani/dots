vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', '<leader>n', vim.diagnostic.open_float, { desc = 'Show diagnostics' })

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])

-- tree keymaps (<leader>e) live in plugins/ui.lua nvim-tree config
-- buffer close (<leader>q) lives in plugins/ui.lua barbar config

-- Select all text in the file
vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = 'Select all text' })
