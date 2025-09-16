return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")

    wk.setup({
      preset = "modern",
      delay = 200,
      expand = 1,
      notify = false,
      -- triggers = {
      --     { "<auto>", mode = "nxso" },
      -- },
    })
  end,
}
