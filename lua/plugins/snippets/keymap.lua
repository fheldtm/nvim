local ls = require("luasnip")

vim.keymap.set("i", "<Tab>", function()
  if ls.expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  else
    return "<Tab>"
  end
end, { silent = true, expr = true })

vim.keymap.set("i", "<S-Tab>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set("s", "<Tab>", function()
  ls.jump(1)
end, { silent = true })

vim.keymap.set("s", "<S-Tab>", function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    return "<Plug>luasnip-next-choice"
  else
    return "<C-E>"
  end
end, { silent = true, expr = true })
