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

-- Code Action
vim.keymap.set(
  "n",
  "<leader>ca",
  function()
    vim.lsp.buf.code_action()
  end,
  { desc = "Code Action", noremap = true, silent = true }
)

vim.keymap.set("n", "<leader>q", function()
  require("quicker").toggle()
end, {
  desc = "Toggle quickfix",
})

vim.keymap.set("n", "<leader>l", function()
  require("quicker").toggle({ loclist = true })
end, {
  desc = "Toggle loclist",
})

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
