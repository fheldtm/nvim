return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Git 작업에 필요
  },
  config = function()
    require("claude-code").setup({
      window = {
        position = "float",
        float = {
          width = "90%",
          height = "90%",
          row = "center",
          col = "center",
          border = "double",
        },
      },
    })
  end
}
