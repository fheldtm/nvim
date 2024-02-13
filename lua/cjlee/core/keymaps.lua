-- global mapleader change
vim.g.mapleader = " "

-- remove unused default keymap
vim.keymap.set("n", "s", "<Nop>")
vim.keymap.set("n", "S", "<Nop>")

-- set keymap
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "ss", "<C-w>s")
vim.keymap.set("n", "sv", "<C-w>v")

vim.keymap.set("n", "<C-c>", "<Escape>")
vim.keymap.set("i", "<C-c>", "<Escape>")
vim.keymap.set("v", "<C-c>", "<Escape>")
