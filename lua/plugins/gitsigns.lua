return {
  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },

  -- Git commands integration
  {
    "tpope/vim-fugitive",
    cmd = {
      "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove",
      "GDelete", "GBrowse", "GRemove", "GRename", "Glgrep", "Gedit"
    },
    ft = {"fugitive"},
    config = function()
      -- Key mappings for common fugitive commands
      vim.keymap.set('n', '<leader>gs', ':Git<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>gd', ':Gdiffsplit<CR>', { desc = 'Git diff' })
      vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
      vim.keymap.set('n', '<leader>gl', ':Git log<CR>', { desc = 'Git log' })
      vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', { desc = 'Git blame' })
    end
  }
}
