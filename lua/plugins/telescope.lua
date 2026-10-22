return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word" },
    { "<leader>fb", "<cmd>Telescope buffers sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Recent files" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
  },
  opts = {
    defaults = { file_ignore_patterns = { "node_modules/", ".git/" } },
    pickers = { find_files = { hidden = true } },
  },
}
