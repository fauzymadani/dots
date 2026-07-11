return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview Open' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Diffview Close' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview File History' },
    },
  },
}
