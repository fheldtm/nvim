return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        local function range()
          return { vim.fn.line("."), vim.fn.line("v") }
        end

        map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hr", function() gs.reset_hunk(range()) end, "Reset hunk")
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("v", "<leader>hs", function() gs.stage_hunk(range()) end, "Stage hunk")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hb", gs.blame_line, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this")
      end,
    },
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
    opts = { diff = { layout = "inline" } },
    keys = {
      { "<leader>gv", "<cmd>CodeDiff<cr>", desc = "CodeDiff (working tree)" },
      { "<leader>gh", "<cmd>CodeDiff history %<cr>", desc = "File history (current)" },
      { "<leader>gH", "<cmd>CodeDiff history<cr>", desc = "File history (repo)" },
    },
  },
}
