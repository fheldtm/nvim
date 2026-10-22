local map = vim.keymap.set

map("n", "s", "<Nop>", { desc = "Disabled" })
map("n", "S", "<Nop>", { desc = "Disabled" })
map("n", "sh", "<C-w>h", { desc = "Window left" })
map("n", "sj", "<C-w>j", { desc = "Window down" })
map("n", "sk", "<C-w>k", { desc = "Window up" })
map("n", "sl", "<C-w>l", { desc = "Window right" })
map("n", "sp", "<C-w>s", { desc = "Split horizontal" })
map("n", "sv", "<C-w>v", { desc = "Split vertical" })

map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

map("i", "jk", "<Esc>", { desc = "Escape" })
map({ "n", "i", "v" }, "<C-c>", "<Esc>", { desc = "Escape" })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })
map("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Delete buffer" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up", silent = true })

map("n", "<leader>uw", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })

map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

map("n", "<leader>uu", function()
  vim.cmd.packadd("nvim.undotree")
  vim.cmd.Undotree()
end, { desc = "Undo tree" })

map("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end, { expr = true, desc = "Next completion" })
map("i", "<S-Tab>", function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>" end, { expr = true, desc = "Prev completion" })
map("i", "<CR>", function()
  if vim.fn.pumvisible() == 1 and vim.fn.complete_info({ "selected" }).selected ~= -1 then
    return "<C-y>"
  end
  return "<CR>"
end, { expr = true, desc = "Confirm completion" })
