return {
  'akinsho/flutter-tools.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require("flutter-tools").setup({
      widget_guides = {
        enabled = true,
      },
      lsp = {
        enabled = true
      }
    })
  end,
}
