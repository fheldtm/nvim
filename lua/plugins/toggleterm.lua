return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local Terminal = require('toggleterm.terminal').Terminal
    local lazygit  = Terminal:new({
      cmd = 'lazygit',
      dir = 'git_dir',
      direction = 'float',
      float_opts = {
        border = 'double',
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        vim.keymap.set('t', '<esc>', '<esc>', { noremap = true, silent = true })
      end,
      on_close = function()
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set('n', '<leader>g', '<cmd>lua _lazygit_toggle()<CR>', { noremap = true, silent = true })
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

    vim.keymap.set('n', '<C-\\><C-\\>', '<cmd>:ToggleTerm<CR>', { noremap = true, silent = true })
    vim.keymap.set('t', '<C-\\><C-\\>', '<cmd>:ToggleTerm<CR>', { noremap = true, silent = true })

    vim.keymap.set('n', '<C-\\>l', '<cmd>:TermSelect<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>1', '<cmd>:ToggleTerm 1<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>2', '<cmd>:ToggleTerm 2<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>3', '<cmd>:ToggleTerm 3<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>4', '<cmd>:ToggleTerm 4<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>5', '<cmd>:ToggleTerm 5<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>6', '<cmd>:ToggleTerm 6<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>7', '<cmd>:ToggleTerm 7<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>8', '<cmd>:ToggleTerm 8<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<C-\\>9', '<cmd>:ToggleTerm 9<CR>', { noremap = true, silent = true })

    require('toggleterm').setup({
      -- open_mapping = [[<c-\>]],
      direction = 'float'
    })
  end
}
