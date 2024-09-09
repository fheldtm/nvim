if OPENAI_KEY == nil then
  print("OPENAI_KEY is not available")
end

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",              -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For working with files with slash commands
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        openai = function()
          return require("codecompanion.adapters").extend("openai", {
            env = {
              api_key = OPENAI_KEY,
            },
            schema = {
              model = {
                default = "gpt-4o-mini",
              },
            },
          })
        end,
      },
    })
  end
}
