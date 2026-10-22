local o = vim.o

o.number = true
o.relativenumber = true
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.wrap = true
o.linebreak = true
o.showbreak = "↪ "
o.ignorecase = true
o.smartcase = true
o.cursorline = true
o.termguicolors = true
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
o.splitright = true
o.splitbelow = true
o.swapfile = false
o.undofile = true
o.mouse = "a"
o.autoread = true
o.updatetime = 300

o.autocomplete = true
o.complete = ".^5,w^5,b^5,u^5"
o.completeopt = "menuone,noselect,popup,fuzzy"

if vim.fn.has("win32") == 1 then
  vim.o.shell = "pwsh"
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
