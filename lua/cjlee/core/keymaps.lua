-- global mapleader change
vim.g.mapleader = " "

-- remove unused default keymap
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "S", "<Nop>")
-- set keymap
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")

vim.keymap.set("n", "sp", "<C-w>s")
vim.keymap.set("n", "sv", "<C-w>v")

vim.keymap.set("n", "<C-c>", "<Escape>")
vim.keymap.set("i", "<C-c>", "<Escape>")
vim.keymap.set("v", "<C-c>", "<Escape>")

vim.keymap.set("n", "<leader>sa", "ggVG", { desc = "select all" })

-- go to definition
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- save and auto formatting
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Quick save", silent = true, noremap = true })

-- quit and close buffer
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit window", silent = true, noremap = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer", silent = true, noremap = true })

-- Code Action
vim.keymap.set(
  "n",
  "<leader>ca",
  function()
    vim.lsp.buf.code_action()
  end,
  { desc = "Code Action", noremap = true, silent = true }
)


-- diagnostic
vim.keymap.set('n', '<Leader>df', vim.diagnostic.open_float, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>dn', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>dp', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>dl', vim.diagnostic.setloclist, { noremap = true, silent = true })

-- neovide
---@diagnostic disable-next-line: undefined-field
if vim.g.neovide then
  vim.keymap.set("n", "<C-c>", '"*y :let @+=@*<CR>', { noremap = true, silent = true })
  vim.keymap.set("v", "<C-c>", '"*y :let @+=@*<CR>', { noremap = true, silent = true })
  vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
  vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })
end

-- Key Chords
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- Telescope keymaps (lazy load Telescope first)
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Help tags" })
vim.keymap.set("n", "<leader>fo", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Old files" })
vim.keymap.set("n", "<leader>fr", function()
  require("telescope.builtin").oldfiles()
end, { desc = "Recent files" })
vim.keymap.set("n", "<leader>fw", function()
  require("telescope.builtin").grep_string()
end, { desc = "Find word under cursor" })

-- Comment toggle (requires Comment.nvim plugin)
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment" })
vim.keymap.set("v", "<leader>/", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle comment" })

-- Word wrap toggle
vim.keymap.set("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
  print("Word wrap: " .. (vim.wo.wrap and "ON" or "OFF"))
end, { desc = "Toggle word wrap" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
