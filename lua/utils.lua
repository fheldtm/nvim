local M = {}

M.IS_WINDOWS = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

function M.is_root()
  return not M.IS_WINDOWS and vim.loop.getuid() == 0
end

return M
