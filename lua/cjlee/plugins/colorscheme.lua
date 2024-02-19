local solarizedOsaka = "craftzdog/solarized-osaka.nvim"
local Nightfox = "EdenEast/nightfox.nvim"
local catppuccin = "catppuccin/nvim"

return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = { "italic" },
  },
  config = function()
    require("catppuccin").setup({
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      term_colors = false,
    })

    vim.cmd.colorscheme "catppuccin"
  end,
}
