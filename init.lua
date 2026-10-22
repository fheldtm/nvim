vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 실험 기능: "Press ENTER" 대기 제거 (:help ui2)
pcall(function() require("vim._core.ui2").enable() end)

require("core.options")
require("core.keymaps")
require("core.autocmds")
require("config.lazy")
