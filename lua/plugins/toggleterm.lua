return {
  -- amongst your other plugins
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup({
      size = 10,
      open_mapping = [[<C-\>]],
      on_open = function()
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { buffer = 0, noremap = true, silent = true })
      end
    })
  end
}
