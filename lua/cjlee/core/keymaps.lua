-- global mapleader change
vim.g.mapleader = " "

-- remove unused default keymap
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "S", "<Nop>")
-- set keymap
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "sh", "<C-w>h")
vim.keymap.set("n", "sj", "<C-w>j")
vim.keymap.set("n", "sk", "<C-w>k")
vim.keymap.set("n", "sl", "<C-w>l")

vim.keymap.set("n", "ss", "<C-w>s")
vim.keymap.set("n", "sv", "<C-w>v")

vim.keymap.set("n", "<C-c>", "<Escape>")
vim.keymap.set("i", "<C-c>", "<Escape>")
vim.keymap.set("v", "<C-c>", "<Escape>")

vim.keymap.set('n', '<leader>sa', 'ggVG', { desc = "select all" })

-- save and auto formatting
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Quick save", silent = true, noremap = true })

-- Code Action
vim.keymap.set(
  "n",
  "<leader>ca",
  function()
    vim.lsp.buf.code_action()
  end,
  { desc = "Code Action", noremap = true, silent = true }
)
vim.keymap.set(
  "v",
  "<leader>ca",
  function()
    vim.lsp.buf.code_action()
  end,
  { desc = "Visual Mode Code Action", noremap = true, silent = true }
)
